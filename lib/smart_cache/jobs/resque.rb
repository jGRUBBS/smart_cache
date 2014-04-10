require 'resque'

module SmartCache
  module Jobs
    class Resque
      @queue = :smart_cache

      def self.enqueue_smart_cache(key, yield_content, expiry)
        # TODO: find perform_async equivalent
      end

      def perform(key, yield_content, expiry)
        SmartCache.cache.write( key, yield_content, expires_in: expiry )
      end

    end
  end
end
