FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    name { "Spec User" }
    password { "password123" }
  end

  factory :admin, class: 'User' do
    email { 'admin@example.com' }
    name { 'Admin' }
    password { 'password123' }
  end
end
