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

    # initializer 'heartbeat' do |app|
    #   $inner_redis = Redis.new

    #   heartbeat_thread = Thread.new do
    #     while true
    #       $inner_redis.publish("heartbeat", "heartbeat")
    #       sleep 5.seconds
    #     end
    #   end      
    # end

    config.after_initialize do 
      begin; require 'active_record'; rescue LoadError; end
      if defined? ::ActiveRecord
        require 'inner_message/models/message'
        require 'inner_message/models/message_box'
        require 'inner_message/models/message_token'
      end
      InnerMessage.user_class.send :include, InnerMessage::Messager
    end
  end
end