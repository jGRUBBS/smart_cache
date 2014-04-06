$:.push File.expand_path("../lib", __FILE__)
require "smart_cache/version"

Gem::Specification.new do |s|
  s.name        = "smart_cache"
  s.version     = SmartCache::VERSION
  s.authors     = ["Justin Grubbs"]
  s.email       = ["justin@jgrubbs.net"]
  s.homepage    = "http://github.com/jGRUBBS/smart_cache"
  s.summary     = "User's always receives cached content while the server fetches."
  s.description = "Let the server wait and not your users."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.require_paths = ["lib"]

  s.add_dependency "rails", "~> 3.2.14"
  s.add_dependency "sidekiq"
  s.add_dependency "redis-activesupport"

  s.add_development_dependency "rspec"
  s.add_development_dependency "debugger"
  s.add_development_dependency "timecop"
  s.add_development_dependency "rspec-sidekiq"
end
