require "inner_message/config"
require "inner_message/railtie"
# require "inner_message/helpers/iframe_helper"
require "inner_message/engine"
Dir.glob(File.expand_path('../inner_message/helpers/*', __FILE__)) { |f| require f }