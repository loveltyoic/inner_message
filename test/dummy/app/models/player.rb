class Player < ActiveRecord::Base
  has_one :message_box, class_name: 'InnerMessage::MessageBox', foreign_key: :user_id
end
