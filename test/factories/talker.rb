FactoryGirl.define do
  factory :visitor, class: InnerMessage::Visitor do
  end
end

FactoryGirl.define do
  factory :operator, class: InnerMessage::Operator do
  end
end