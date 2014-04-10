require 'sidekiq/worker'

module SmartCache
  module Jobs
    class Sidekiq
      include ::Sidekiq::Worker
      sidekiq_options :queue => :smart_cache

      def self.enqueue_smart_cache(key, yield_content, expiry)
        perform_in(expiry, key, "", expiry) unless scheduled?(key)
      end

      def self.scheduled?(key)
        items = []
        ::Sidekiq::ScheduledSet.new.each { |job| items << job.item }
        items.select { |item| item["args"][0] == key }.present?
      end

      def perform(key, yield_content, expiry)
        SmartCache.cache.write( key, yield_content, expires_in: expiry + SmartCache::TIME_PAD )
      end

    end
  end
end
