require "sidekiq/worker"

module SmartCache
  class Worker

    include ::Sidekiq::Worker
    sidekiq_options queue: :smart_cache

    def perform(key, value, expiry)
      SmartCache.cache.write( key, value, expires_in: expiry )
    end

  end
end