User.create!(
        name: 'Nikita',
        surname: 'Shkaruba',
        mail: 'sh.nickita@list.ru',
        admin: true,
        activated: true,
        activated_at: Time.zone.now,
        password: 'foobar',
        password_confirmation: 'foobar')

# Users
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

# Their posts
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.posts.create!(content: content) }
end


# Following relationships
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
