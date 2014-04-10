require 'delayed_job'

module SmartCache
  module Jobs
    class DelayedJob < Struct.new(:klass, :method_name, :options)

      def self.enqueue_smart_cache(key, yield_content, expiry)
        # TODO: find perform_async equivalent
      end

      def perform(key, yield_content, expiry)
        SmartCache.cache.write( key, yield_content, expires_in: expiry )
      end

    end
  end
end
