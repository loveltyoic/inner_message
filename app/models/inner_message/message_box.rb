module InnerMessage
  class MessageBox < ActiveRecord::Base
    
    belongs_to :user, class_name: InnerMessage.user_class.to_s
    has_many :messages, as: :messageable

    def self.send_message(params)
      to = InnerMessage.user_class.find(params[:to_id])
      mb = to.message_box || to.create_message_box
      mb.messages.create params
    rescue ActiveRecord::RecordNotFound
      false
    end

  end
end
