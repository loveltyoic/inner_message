# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../../config/environment.rb",  __FILE__)
require "rails/test_help"
require 'minitest/autorun'
require 'capybara/rails'

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL
end
Capybara.javascript_driver = :webkit