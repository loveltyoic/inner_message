require_dependency "inner_message/application_controller"

module InnerMessage
  class BroadcastsController < ApplicationController
    def create
      @broadcast = Broadcast.create(broadcast_params)
      render json: @broadcast
    end
    def read_count
      count = params[:ids].inject({}) do |result, id|
        result.merge!({ "#{id}" => $inner_redis.get("inner_message:#{id}:read_count") })
      end
      render json: count
    end
    private
    def broadcast_params
      params.require(:broadcast).permit(:channel_id, :title, :content)
    end
  end
end
