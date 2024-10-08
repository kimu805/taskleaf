# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create(name: "admin", email: "admin@admin.com", admin: true, password: "111111", password_confirmation: "111111")
User.create(name: "test1", email: "test1@test.com", admin: false, password: "111111", password_confirmation: "111111")

100.times do |i|
  Task.create(name: "admin_task#{i+1}", description: "Description of admin_task#{i+1}", user_id: 1)
  Task.create(name: "task#{i+1}", description: "Description of task#{i+1}", user_id: 2)
end