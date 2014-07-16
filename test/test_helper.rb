# Configure Rails Environment
ENV["RAILS_ENV"] = "test"
ENV["RACK_ENV"] = "test"
if ENV["TEST_MODEL"] == "Mongoid"
  require File.expand_path("../mongoid_app/config/environment.rb",  __FILE__)
else
  require File.expand_path("../dummy/config/environment.rb",  __FILE__)
end

require "rails/test_help"
require 'minitest/autorun'
Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load fixtures from the engine
if ActiveSupport::TestCase.method_defined?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
end

