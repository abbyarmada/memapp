FactoryGirl.define do
  factory :user do |f|
    f.email 'fakeemail@testmailserver.com'
    f.password 'password'
    f.password_confirmation 'password'
    # f.remember_me
  end
end
