module InnerMessage
  class Broadcast < ActiveRecord::Base
    belongs_to :message_channel

  end
end