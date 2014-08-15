module InnerMessage
  class Railtie < ::Rails::Railtie
    initializer 'inner_message' do |app|
      ENV['RACK_ENV'] ||= 'development'

      app.routes.draw do
        mount InnerMessage::Engine => "/inner_message"
      end

      ActiveSupport.on_load(:action_view) do
        ::ActionView::Base.send :include, InnerMessage::ViewExtension
      end

      config_file = File.join(Rails.root, 'config', 'inner_message_config.yml')
      if File.exists? config_file
        ::InnerMessage::CONFIG = YAML.load_file(config_file)[ENV['RACK_ENV']]
        $inner_redis = Redis.new(host: CONFIG['redis']['host'], port: CONFIG['redis']['port'], db: CONFIG['redis']['db'])
      end

    end

    config.after_initialize do
      if defined? ::ActiveRecord
        Dir.glob(File.expand_path('../models', __FILE__)+'/active_record_*.rb') { |file| require file }
      end
      begin; require 'mongoid'; rescue LoadError; end
      if defined? ::Mongoid
        require 'inner_message/models/mongoid_message'
        require 'inner_message/models/mongoid_message_box'
        require 'inner_message/models/mongoid_messager'
        require 'inner_message/models/mongoid_message_token'
      end
      InnerMessage.user_class.send :include, InnerMessage::Messager
    end
  end
end