# Configure Rails Environment
ENV["RAILS_ENV"] = "test"
ENV["RACK_ENV"] = "test"
if ENV["TEST_MODEL"] == "Mongoid"
  require File.expand_path("../mongoid_app/config/environment.rb",  __FILE__)
else
  require File.expand_path("../dummy/config/environment.rb",  __FILE__)
  require 'capybara/rails'
  class ActionDispatch::IntegrationTest
    # Make the Capybara DSL available in all integration tests
    include Capybara::DSL
  end
  Capybara.default_driver = :webkit
end

require "rails/test_help"
require 'minitest/autorun'
Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

class ActiveSupport::TestCase

  include FactoryGirl::Syntax::Methods
end

class MiniTest::Spec
  include FactoryGirl::Syntax::Methods
end

Dir["#{File.dirname(__FILE__)}/factories/*.rb"].each { |f| require f }

