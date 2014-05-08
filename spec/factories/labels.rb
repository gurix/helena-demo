FactoryGirl.define do
  factory :label, class: Helena::Label do
    sequence(:text)  { |n| "Option #{n}" }
    sequence(:value)
    sequence(:position)
  end
end
