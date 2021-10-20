# frozen_string_literal: true

module Gitlab
  module Metrics
    class Sli
      SliNotInitializedError = Class.new(StandardError)

      COUNTER_PREFIX = 'gitlab_sli'

      class << self
        INITIALIZATION_MUTEX = Mutex.new

        def [](name)
          known_slis[name] || initialize_sli(name, [])
        end

        def initialize_sli(name, possible_label_combinations)
          INITIALIZATION_MUTEX.synchronize do
            sli = new(name)
            sli.initialize_counters(possible_label_combinations)
            known_slis[name] = sli
          end
        end

        def initialized?(name)
          known_slis.key?(name) && known_slis[name].initialized?
        end

        private

        def known_slis
          @known_slis ||= {}
        end
      end

      attr_reader :name

      def initialize(name)
        @name = name
        @initialized_with_combinations = false
      end

      def initialize_counters(possible_label_combinations)
        @initialized_with_combinations = possible_label_combinations.any?
        possible_label_combinations.each do |label_combination|
          total_counter.get(label_combination)
          success_counter.get(label_combination)
        end
      end

      def increment(labels:, success:)
        total_counter.increment(labels)
        success_counter.increment(labels) if success
      end

      def initialized?
        @initialized_with_combinations
      end

      private

      def total_counter
        prometheus.counter(total_counter_name.to_sym, "Total number of measurements for #{name}")
      end

      def success_counter
        prometheus.counter(success_counter_name.to_sym, "Number of successful measurements for #{name}")
      end

      def total_counter_name
        "#{COUNTER_PREFIX}:#{name}:total"
      end

      def success_counter_name
        "#{COUNTER_PREFIX}:#{name}:success_total"
      end

      def prometheus
        Gitlab::Metrics
      end
    end
  end
end
