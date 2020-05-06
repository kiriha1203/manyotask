# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(
  email: 'admin@test.com',
  name: 'admin',
  admin: true,
  password: 'password',
  password_confirmation: 'password'
)

40.times do |n|
  user.tasks.create!(name: "task#{n+1}",
               content: "sample_task#{n+2}",
               end_deadline: '2030-05-30',
               priority: "低",
               status: "未着手"
  )
end
