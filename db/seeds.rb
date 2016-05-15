# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

99.times do |n|
  name  = Faker::Name.name
  surname = Faker::Name.name
  mail = "example#{n+1}@mail.ru"
  password = 'password'

  User.create!(name:    name,
               surname: surname,
               mail:    mail,
               password:              password,
               password_confirmation: password)
end
