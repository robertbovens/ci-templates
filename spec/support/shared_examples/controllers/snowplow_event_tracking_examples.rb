# frozen_string_literal: true
#
# Requires a context containing:
# - subject
# - feature_flag_name
# - category
# - action
# - namespace
# Optionaly, the context can contain:
# - project
# - property
# - user
# - label
# - **extra

RSpec.shared_examples 'Snowplow event tracking' do |overrides: {}|
  let(:extra) { {} }

  it 'is not emitted if FF is disabled' do
    stub_feature_flags(feature_flag_name => false)

    subject

    expect_no_snowplow_event(category: category, action: action)
  end

  it 'is emitted' do
    params = {
      category: category,
      action: action,
      namespace: namespace,
      user: try(:user),
      project: try(:project),
      label: try(:label),
      property: try(:property),
      context: try(:context)
    }.merge(overrides).compact.merge(extra)

    subject

    expect_snowplow_event(**params)
  end
end

RSpec.shared_examples 'Snowplow event tracking with RedisHLL context' do |overrides: {}|
  it_behaves_like 'Snowplow event tracking', overrides: overrides do
    let(:context) do
      event = try(:property) || action
      [Gitlab::Tracking::ServicePingContext.new(data_source: :redis_hll, event: event).to_context.to_json]
    end
  end
end
