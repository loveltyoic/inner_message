$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "inner_message/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "inner_message"
  s.version     = InnerMessage::VERSION
  s.authors     = ["LiZihe"]
  s.email       = ["loveltyoic@gmail.com"]
  s.homepage    = "https://github.com/loveltyoic/inner_message"
  s.summary     = "Embedded message system for rails app."
  s.description = "Embedded message system for rails app."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 4.0.0"
  s.add_dependency "faye"
  s.add_dependency "thin"
  s.add_dependency "eventmachine"
  s.add_dependency "redis"

  # s.add_development_dependency "sqlite3"
end
