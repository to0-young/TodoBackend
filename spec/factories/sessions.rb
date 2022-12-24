FactoryBot.define do
  factory :session do
    expiration { "2022-12-24 12:05:21" }
    token { "MyString" }
  end
end
