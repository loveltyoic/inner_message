module InnerMessage
  module Generators
    class ConfigGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
      def copy_config_file
        copy_file "inner_message.rb", "config/initializers/inner_message_config.rb"
      end
    end
  end
end
