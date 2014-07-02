module InnerMessage
  class MessageBox < ActiveRecord::Base
    belongs_to :user, class_name: InnerMessage.user_class.to_s
    has_many :messages

    def self.send_message(params)
      to = InnerMessage.user_class.find_by(InnerMessage.name_field.to_sym => params[:to])
      if to
        mb = MessageBox.find_or_create_by(user_id: to.id)
        mb.messages.create params
      end
      to
    end
  end
end
