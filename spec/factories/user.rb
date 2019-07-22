FactoryBot.define do
    factory :user do
      name { Faker::Name.name }
      password { Faker::Internet.password }
      city { Faker::Address.city }
      email { Faker::Internet.email }
    end
    factory :invalid_user, class: 'User' do
      name {}
      password { Faker::Internet.password }
      city {}
      email { Faker::Internet.email }
    end
    factory :user1, class: 'User' do
      name { 'John' }
      password { 'password' }
      mobile { '90909090' }
      email { 'john@example.com' }
    end
  end