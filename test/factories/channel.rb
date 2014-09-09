FactoryGirl.define do
  factory :channel, class: InnerMessage::Channel do
    sequence(:name) { |n| "channel_#{n}" }
  end
end

FactoryGirl.define do
  factory :system_channel, class: InnerMessage::SystemChannel do
    sequence(:name) { |n| "system_channel#{n}" }
  end
end