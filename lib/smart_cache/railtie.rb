require 'smart_cache'

module SmartCache

  if defined? Rails::Railtie
    require 'rails'

    # On initialzation, include DelayedCron
    class Railtie < Rails::Railtie
      initializer 'smart_cache.insert_into_active_record' do
        ActiveSupport.on_load :active_record do
          SmartCache::Railtie.insert
        end
      end
    end
  end

  class Railtie

    # Glue includes SmartCache ControllerMethods and ModelMethods
    def self.insert
      ActionController::Base.send(:include, SmartCache::ControllerGlue)
      ActiveRecord::Base.send(:include, SmartCache::ModelGlue)
    end

  end

end
