FactoryBot.define do
  factory :task do
    title { Faker::Verb.base }
    description { Faker::Markdown.emphasis }
    priority { 1 }
    due_date { 1.day.from_now }
    user
  end
end
