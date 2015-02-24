FactoryGirl.define do
  require 'faker'
  factory :user do |f|
    f.email  { Faker::Internet.email }
    f.password "password"
    f.password_confirmation "password"
   # f.remember_me
  end
end
