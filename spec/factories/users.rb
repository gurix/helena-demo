FactoryGirl.define do
  factory :user do
    name { "#{Faker::Name.first_name} #{Faker::Name.last_name}" }
    email { Faker::Internet.email }
    password {  Faker::Lorem.words(8).join }
  end
end
