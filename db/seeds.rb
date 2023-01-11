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

  task_1 = Task.create_with(
    due_date: DateTime.now,
    priority: 1,
    description: 'Sample desk'
  ).find_or_create_by!(user_id: user.id, title: 'Sample task')

  task_2 = Task.create_with(
    due_date: DateTime.now,
    priority: 1,
    description: 'Sample desk 2'
  ).find_or_create_by!(user_id: user.id, title: 'Sample task 2')
end


