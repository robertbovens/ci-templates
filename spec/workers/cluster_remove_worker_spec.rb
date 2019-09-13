# frozen_string_literal: true

require 'spec_helper'

describe ClusterRemoveWorker do
  describe '#perform' do
    subject { worker_instance.perform(cluster.id) }

    let!(:worker_instance) { described_class.new }
    let!(:cluster) { create(:cluster, :project, provider_type: :gcp) }
    let!(:logger) { worker_instance.send(:logger) }
    let(:log_meta) do
      {
        service: described_class.name,
        cluster_id: cluster.id,
        execution_count: 0
      }
    end

    shared_examples 'removing cluster' do
      it 'sets cluster as removing' do
        expect_any_instance_of(Clusters::Cluster).to receive(:removing!)

        subject
      end
    end

    context 'when cluster has no applications or roles' do
      let!(:cluster) { create(:cluster, :with_environments) }
      let(:kubeclient_intance_double) do
        instance_double(Gitlab::Kubernetes::KubeClient, delete_namespace: nil, delete_service_account: nil)
      end

      before do
        allow_any_instance_of(Clusters::Cluster).to receive(:kubeclient).and_return(kubeclient_intance_double)
      end

      it_behaves_like 'removing cluster'

      it 'stops removing cluster' do
        expect_any_instance_of(Clusters::Cluster).to receive(:stop_removing!)

        subject
      end

      it 'deletes namespaces' do
        expect(kubeclient_intance_double).to receive(:delete_namespace).with(cluster.kubernetes_namespaces[0].namespace)
        expect(kubeclient_intance_double).to receive(:delete_namespace).with(cluster.kubernetes_namespaces[1].namespace)

        subject
      end

      it 'deletes cluster' do
        subject

        expect(Clusters::Cluster.where(id: cluster.id).exists?).to eq(false)
      end

      it 'logs all events' do
        expect(logger).to receive(:info)
          .with(log_meta.merge(event: :deleting_namespace, namespace: cluster.kubernetes_namespaces[0].namespace))
        expect(logger).to receive(:info)
          .with(log_meta.merge(event: :deleting_namespace, namespace: cluster.kubernetes_namespaces[1].namespace))
        expect(logger).to receive(:info)
          .with(log_meta.merge(event: :deleting_gitlab_service_account))
        expect(logger).to receive(:info)
          .with(log_meta.merge(event: :deleting_cluster_reference))

        subject
      end
    end

    context 'when cluster has uninstallable applications' do
      before do
        allow(described_class)
          .to receive(:perform_in)
          .with(20.seconds, cluster.id, 1)
      end

      shared_examples 'reschedules itself' do
        it 'reschedules itself' do
          expect(described_class)
            .to receive(:perform_in)
            .with(20.seconds, cluster.id, 1)

          subject
        end
      end

      context 'has applications with dependencies' do
        let!(:helm) { create(:clusters_applications_helm, :installed, cluster: cluster) }
        let!(:ingress) { create(:clusters_applications_ingress, :installed, cluster: cluster) }
        let!(:cert_manager) { create(:clusters_applications_cert_manager, :installed, cluster: cluster) }
        let!(:jupyter) { create(:clusters_applications_jupyter, :installed, cluster: cluster) }

        it_behaves_like 'removing cluster'
        it_behaves_like 'reschedules itself'

        it 'only uninstalls apps that are not dependencies for other installed apps' do
          expect(Clusters::Applications::UninstallService)
            .not_to receive(:new).with(helm)

          expect(Clusters::Applications::UninstallService)
            .not_to receive(:new).with(ingress)

          expect(Clusters::Applications::UninstallService)
            .to receive(:new).with(cert_manager)
            .and_call_original

          expect(Clusters::Applications::UninstallService)
            .to receive(:new).with(jupyter)
            .and_call_original

          subject
        end

        it 'logs application uninstalls and next execution' do
          expect(logger).to receive(:info)
            .with(log_meta.merge(event: :uninstalling_app, application: kind_of(String))).exactly(2).times
          expect(logger).to receive(:info)
            .with(log_meta.merge(event: :scheduling_execution, next_execution: 1))

          subject
        end
      end

      context 'when applications are still uninstalling/scheduled' do
        let!(:helm) { create(:clusters_applications_helm, :installed, cluster: cluster) }
        let!(:ingress) { create(:clusters_applications_ingress, :scheduled, cluster: cluster) }
        let!(:runner) { create(:clusters_applications_runner, :uninstalling, cluster: cluster) }

        it_behaves_like 'reschedules itself'

        it 'does not call the uninstallation service' do
          expect(Clusters::Applications::UninstallService)
            .not_to receive(:new)

          subject
        end
      end
    end

    context 'when exceeded the execution limit' do
      subject { worker_instance.perform(cluster.id, described_class::EXECUTION_LIMIT) }

      let(:worker_instance) { described_class.new }
      let(:logger) { worker_instance.send(:logger) }

      it 'stops removing cluster' do
        expect_any_instance_of(Clusters::Cluster).to receive(:stop_removing!)

        subject
      end

      it 'logs the error' do
        expect(logger).to receive(:error)
        .with(
          hash_including(
            exception: 'ClusterRemoveWorker::ExceededExecutionLimitError',
            cluster_id: kind_of(Integer),
            class_name: described_class.name,
            event: :failed_to_remove_cluster_and_resources,
            message: 'retried too many times'
          )
        )

        subject
      end
    end
  end
end
