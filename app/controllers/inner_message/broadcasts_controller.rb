require_dependency "inner_message/application_controller"

module InnerMessage
  class BroadcastsController < ApplicationController
    def create
      @broadcast = Broadcast.create(broadcast_params)
      render json: @broadcast
    end

    private
    def broadcast_params
      params.require(:broadcast).permit(:channel_id, :title, :content)
    end
  end
end
