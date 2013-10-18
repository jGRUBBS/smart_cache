module SmartCache
  class Cache

    def fetch(key, *options, &block)
      expires_in  = options.first[:expires_in]
      read_or_write(key, expires_in, yield)
      read(key)
    end

    def read(key)
      SmartCache.cache.read(key)
    end

    def write(key, value, expiry)
      SmartCache.cache.write(key, value, expiry)
    end

    def read_or_write(key, expires_in, yield_content)
      if SmartCache.cache.read(key)
        # does not work with dalli but works with all other cache methods
        cache_created_at = Time.at(SmartCache.cache.send(:read_entry, key, {}).created_at)
        expiration_time  = cache_created_at + expires_in

        if expiration_time < Time.now
          SmartCache::Worker.perform_async( key, yield_content, (expires_in + 24.hours) )
        end

      else 
        SmartCache.cache.write(key, yield_content, expires_in: expires_in + 24.hours )
      end
    end
  
  end
end