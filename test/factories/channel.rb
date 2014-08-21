FactoryGirl.define do
  factory :channel, class: InnerMessage::Channel do 
    sequence(:name) { |n| "channel_#{n}" }
  end
end
