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
        ::ActionView::Base.send :include, InnerMessage::IframeHelper
      end
    end

    initializer 'heartbeat' do |app|
      $inner_redis = Redis.new

      heartbeat_thread = Thread.new do
        while true
          $inner_redis.publish("heartbeat", "heartbeat")
          sleep 5.seconds
        end
      end      
    end

    config.after_initialize do 
      InnerMessage.user_class.class_eval do
        include InnerMessage::Messager
      end
    end
  end
end