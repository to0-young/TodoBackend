FactoryBot.define do
  factory :session do
    expiration { 1.day.from_now }
    user
  end
end
