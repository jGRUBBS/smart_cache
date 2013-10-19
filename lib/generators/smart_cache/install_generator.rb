require 'rails/generators/migration'

module SmartCache
  module Generators
    class InstallGenerator < Rails::Generators::Base
      def append_application_helper
        insert_into_file File.join('app', 'helpers', 'application_helper.rb'), :after => "module ApplicationHelper\n" do
          %Q{
  def smart_cache
    SmartCache::Cache.new
  end
          }
        end
      end
    end
  end
end