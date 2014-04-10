require "active_support/cache"
require "sidekiq"
require "smart_cache/jobs"
require "smart_cache/cache"
require "smart_cache/railtie"

module SmartCache

  TIME_PAD = 24.hours

  class << self

    def cache
      @cache ||= ActiveSupport::Cache.lookup_store(:dalli_store)
    end

    def processor
      return SmartCache::Jobs::DelayedJob if defined? ::Delayed::Job
      return SmartCache::Jobs::Resque     if defined? ::Resque
      return SmartCache::Jobs::Sidekiq    if defined? ::Sidekiq
    end

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
