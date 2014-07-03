module InnerMessage
  class MessageBox < ActiveRecord::Base

    belongs_to :user, class_name: InnerMessage.user_class.to_s
    has_many :messages, as: :messageable

  end
end
