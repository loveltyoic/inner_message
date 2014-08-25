require_dependency "inner_message/application_controller"

module InnerMessage
  class ChannelsController < ApplicationController
    def create
      @channel = Channel.create(name: params[:name])
      render json: @channel
    end

    def index 
      @channels = Channel.all
      render json: @channels
    end
  end
end
