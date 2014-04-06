require "active_support/cache"
require "sidekiq"
require "smart_cache/cache"
require "smart_cache/worker"
require "smart_cache/railtie"

module SmartCache

  def self.cache
    @cache ||= ActiveSupport::Cache.lookup_store(:redis_store)
  end

  module ControllerGlue
    def self.included(base)
      base.extend(ControllerMethods)
    end
  end

  module ModelGlue
    def self.included(base)
      base.extend(ModelMethods)
    end
  end

  module ControllerMethods

    # grabs list of actions from controller
    # 
    # class SomeController < ApplicationController
    #   smart_caches :some_action, :another_action
    #   ...
    # end
    #
    def smart_caches(*caches)
      # FIXME: what should we do here?
    end

  end

  module ModelMethods

    # grabs list of actions from model
    # 
    # class SomeModel < ActiveRecord::Base
    #   smart_cache :some_action
    #   ...
    # end
    #
    def smart_cache(*caches)
      # FIXME: what should we do here?
    end

  end

end
