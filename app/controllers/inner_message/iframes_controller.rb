require_dependency "inner_message/application_controller"

module InnerMessage
  class IframesController < ApplicationController
    before_action :sign_in_user
    def show
      @token = current_talker.session_key
      @faye_server = CONFIG['faye']['server']
    end

    def channels 
      channels = signed_user.channels
      @channels = channels.inject([]) do |cs, c|
        cs.push({ id: c.id, name: c.name, broadcasts: signed_user.get_unread_broadcasts_by_channel_id(c.id) })
      end
      render json: @channels
    end
  end
end
