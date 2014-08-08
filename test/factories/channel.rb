FactoryGirl.define do
  factory :message_channel, class: InnerMessage::MessageChannel do 
    sequence(:name) { |n| "channel_#{n}" }
  end
end
