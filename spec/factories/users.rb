FactoryGirl.define do
  factory :user do
    name Faker::Name.name
    email { Faker::Internet.email }
    password { Faker::Internet.password(8)}
    auth_token { Faker::Internet.password(24) }
  end
end
