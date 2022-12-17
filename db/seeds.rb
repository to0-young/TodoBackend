require "faker"

5.times do |n|
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
end


