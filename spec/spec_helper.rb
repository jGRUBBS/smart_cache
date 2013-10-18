require "smart_cache"
require "timecop"
require "rspec-sidekiq"

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.order = 'random'

  config.before(:each) do
    SmartCache.cache.clear
  end

end

RSpec::Sidekiq.configure do |config|

end