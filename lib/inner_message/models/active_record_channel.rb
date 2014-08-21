module InnerMessage
  class Channel < ActiveRecord::Base
    has_many :users, class_name: InnerMessage.user_class.to_s, through: :subscriptions
    has_many :subscriptions
    has_many :broadcasts

    validates :name, presence: true

    def send_broadcast(title, content)
      broadcasts.create(title: title, content: content)
    end

  end
end