require_dependency "inner_message/application_controller"

module InnerMessage
  class ChannelsController < ApplicationController
    def create
      @channel = params[:system] ? SystemChannel.create(name: params[:name]) : Channel.create(name: params[:name])
      render json: @channel
    end

    def index
      @channels = Channel.all
      render json: @channels
    end

    def broadcasts
      @broadcasts = Broadcast.where(channel_id: params[:id])
      @broadcasts_with_readcount = @broadcasts.inject([]) { |brs, br| brs.push br.serializable_hash.merge({read: br.read_count}) }
      render json: @broadcasts_with_readcount
    end
  end
end
