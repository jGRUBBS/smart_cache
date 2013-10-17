require "active_support/cache"
# require "redis"

module SmartCache
  class Cache

    attr_accessor :cache

    def initialize
      @cache ||= ActiveSupport::Cache::MemoryStore.new
    end

    def fetch(initial_key, *related_objects, &block)
      expires_in  = related_objects.first[:expires_in]
      real_expiry = Time.now + expires_in
      if cache.read(initial_key)
        # might not work with dalli
        cache_created_at = Time.at(cache.send(:read_entry, initial_key, {}).created_at)
        expiration_time  = cache_created_at + expires_in

        if expiration_time < Time.now
          # write cache in background
        end

      else 
        cache.write(initial_key, yield, *related_objects )
      end
      cache.read(initial_key)
    end
  
  end
end
