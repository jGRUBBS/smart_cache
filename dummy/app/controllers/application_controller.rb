class ApplicationController < ActionController::Base
  protect_from_forgery

  smart_caches :test_cache, :test_cache_two

  def test_cache
    puts "running test cache"
  end

end
