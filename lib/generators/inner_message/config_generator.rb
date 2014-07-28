module InnerMessage
  module Generators
    class ConfigGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
      def copy_config_file
        copy_file "inner_message.rb", "config/initializers/inner_message.rb"
        copy_file "inner_message_config.yml", "config/inner_message_config.yml"
      end
    end
  end
end
