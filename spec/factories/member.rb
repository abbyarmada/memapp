FactoryGirl.define do
  require 'faker'
factory :member do |f|
#     f.association :privilege
     f.privilege_id 1
     f.proposed "John Doe"
     f.seconded "Jane Doe"
     f.year_joined "2014"
     f.occupation "System Tester"
     f.renew_date "01.01.2014"
     f.name_no "1234"
     f.street1 "Test street name 1"
     f.country "Ireland"
   end
end