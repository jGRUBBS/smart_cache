$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "smart_cache/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "smart_cache"
  s.version     = SmartCache::VERSION
  s.authors     = ["Justin Grubbs"]
  s.email       = ["justin@jgrubbs.net"]
  s.homepage    = "http://github.com/jGRUBBS/smart_cache"
  s.summary     = "User's always receives cached content while the server fetches."
  s.description = "Let the server wait and not your users."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.14"

  s.add_development_dependency "rspec"
  s.add_development_dependency "debugger"
end
