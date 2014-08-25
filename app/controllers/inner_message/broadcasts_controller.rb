require_dependency "inner_message/application_controller"

module InnerMessage
  class BroadcastsController < ApplicationController
    def read_count
      count = params[:ids].inject({}) do |result, id|
        result.merge!({ "#{id}" => $redis.get("inner_message:#{id}:read_count") })
      end
      render json: count
    end
  end
end
