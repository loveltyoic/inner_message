require_relative './active_record_talker'
module InnerMessage
  class Agent < Talker
    belongs_to :user, class_name: InnerMessage.user_class.to_s
  end
end