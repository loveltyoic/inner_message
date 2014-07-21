module InnerMessage
  class Railtie < ::Rails::Railtie
    initializer 'inner_message' do |app|
      if ENV['RAILS_ENV'] == 'development'
        app.configure do
          config.preload_frameworks = true
          config.allow_concurrency = true 
        end   
      end
      app.routes.draw do
        mount InnerMessage::Engine => "/inner_message"
      end
      ActiveSupport.on_load(:action_view) do
        ::ActionView::Base.send :include, InnerMessage::ViewExtension
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