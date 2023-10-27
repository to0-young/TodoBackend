require "faker"

1.times do |n|
  # user = User.new(
  #   first_name: "jonny",
  #   last_name: "joo",
  #   email: "user_#{n}@gmail.com",
  #   password: "123",
  # )
  # user.save!

  # user = User.create!(
  #   first_name: "jonny",
  #   last_name: "joo",
  #   email: "user_#{n}@gmail.com",
  #   password: "123",
  # )

  user = User.create_with(
    password: "123",
    first_name: "jonny",
    last_name: "joo",
  ).find_or_create_by!(email: "user_#{n}@gmail.com")

50.times do |n|
    Task.create_with(
      due_date: DateTime.now,
      priority: rand(1..10),
      description: 'Sample desk 1'
    ).find_or_create_by!(user_id: user.id, title: "RondomTask#{n}", )
  end
end

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?