require "active_support/cache"
require "sidekiq"
require "smart_cache/cache"
require "smart_cache/worker"

module SmartCache

  mattr_accessor :cache

  def self.cache
    @cache ||= ActiveSupport::Cache.lookup_store(:redis_store)
  end

end
