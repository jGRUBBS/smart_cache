module SmartCache
  class Cache

    def fetch(key, options = {}, &block)
      @key, @expires_in = key, options[:expires_in]
      unless val = read
        schedule_async_action(yield)
        val = write(yield, expires_in: @expires_in + SmartCache::TIME_PAD )
      end
      val
    end

    private

    def read
      SmartCache.cache.read(@key)
    end

    def schedule_async_action(yield_content)
      SmartCache.processor.enqueue_smart_cache( @key, yield_content, @expires_in )
    end

    def write(yield_content, expiry)
      SmartCache.cache.write(@key, yield_content, expiry)
      yield_content
    end

  end
end
