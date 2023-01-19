FactoryBot.define do
  factory :user do
    password { Faker::Internet.password }
    email { "#{Faker::Internet.username(specifier: 8)}@gmail.com" }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end
end
