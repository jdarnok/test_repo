FactoryGirl.define do
  factory :commit do
    name { Faker::Company.catch_phrase }
    hash_string { Faker::Lorem.characters(40) }
    user
    project
    branch
  end

end
