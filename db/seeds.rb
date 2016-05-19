# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
User.create!(
        name: 'Nikita',
        surname: 'Shkaruba',
        mail: 'sh.nickita@list.ru',
        admin: true,
        activated: true,
        activated_at: Time.zone.now,
        password: 'foobar',
        password_confirmation: 'foobar')

99.times do |n|
  fullName = Faker::Name.name.split(' ', 2)

  name  = fullName[0]
  surname = fullName[0]
  mail = "#{name}_#{n+1}@mail.ru"
  password = 'password'

  User.create!(name:    name,
               surname: surname,
               mail:    mail,
               activated: true,
               activated_at: Time.zone.now,
               password:              password,
               password_confirmation: password)
end
