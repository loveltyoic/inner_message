module InnerMessage
  module Generators
    class FayeGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
      def copy_faye_file
        copy_file "config.ru", "faye_server/config.ru"
        copy_file "thin.yml", "faye_server/thin.yml"
        copy_file ".gitignore", "faye_server/.gitignore"
        copy_file "start_faye", "faye_server/start_faye"
      end
    end
  end
end
