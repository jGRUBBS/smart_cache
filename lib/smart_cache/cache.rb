module SmartCache
  class Cache

    def fetch(key, options = {}, &block)
      @key, @expires_in = key, options[:expires_in]
      read_or_write(yield)
    end

    private

    def read_or_write(yield_content)
      if val = read
        schedule_async_action(yield_content) if expired?
      else
        val = write(yield_content, expires_in: @expires_in + 24.hours )
      end

      val
    end

    def read
      SmartCache.cache.read(@key)
    end

    def expired?
      expires_at < Time.now
    end

    def expires_at
      created_at + @expires_in
    end

    def created_at
      # does not work with dalli but works with all other cache methods
      Time.at(SmartCache.cache.send(:read_entry, @key, {}).created_at)
    end

    def schedule_async_action(yield_content)
      SmartCache::Worker.perform_async( @key, yield_content, (@expires_in + 24.hours) )
    end

    def write(yield_content, expiry)
      SmartCache.cache.write(@key, yield_content, expiry)
      yield_content
    end

  end
end
