FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password {  Faker::Lorem.words(8).join }
  end
end
