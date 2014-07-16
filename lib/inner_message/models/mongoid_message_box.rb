module InnerMessage
  class MessageBox
    include Mongoid::Document
    
    belongs_to :user, class_name: InnerMessage.user_class.to_s, inverse_of: :message_box
    has_many :messages, as: :messageable

  end
end
