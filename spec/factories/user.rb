require 'faker'
FactoryBot.define do
    
    
    factory :user1, class: 'User' do
      name { 'John' }
      password { 'password' }
      mobile { '90909090' }
      email { 'john@example.com' }
      date_of_birth {  DateTime.civil(2010, 01, 10, 0, 0, 0, 0) }
    end

    factory :user2, class: 'User' do
      name { 'John2' }
      password { 'password' }
      mobile { '90909090' }
      email { 'john2@example.com' }
      date_of_birth {  DateTime.civil(2011, 01, 10, 0, 0, 0, 0) }
    end

    factory :user3, class: 'User' do
      name { Faker::Name.name }
      password { 'password' }
      mobile { Faker::PhoneNumber.cell_phone }
      email { Faker::Internet.email  }
      date_of_birth {  Faker::Date.between(22.year.ago, 20.year.from_now) }
    end
  end


  