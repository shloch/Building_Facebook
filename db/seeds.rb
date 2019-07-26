# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



15.times do |n|
  name  = Faker::Name.name
  email = Faker::Internet.email
  password = "password"
  mobile = Faker::PhoneNumber.cell_phone
  User.create!(name:  name,
               email: email,
               password: password,
               mobile: mobile,
               password_confirmation: password,)
  end


  users = User.order(:created_at).take(5)

  5.times do
    blog_text = Faker::Lorem.sentence(5)
    date =  Faker::Time.between(2.days.ago, Time.now)
    users.each { |user| user.posts.create!(post_text: blog_text, created_at: date) }
  end
