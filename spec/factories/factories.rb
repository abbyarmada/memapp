FactoryGirl.define do 
  require 'faker'
   factory :person do |f|
     f.member_id 1
     f.first_name  { Faker::Name.first_name }
     f.last_name { Faker::Name.last_name }
     f.status 'm'
     f.child_dob ''
     f.home_phone '01-845-1234'
     f.email_address 'blah@example.com'
     f.comm_prefs ''
     f.snd_txt 'y'
     f.snd_eml 'y'
     f.dob '01.01.2011'
     f.member_number 1
     f.txt_bridge 1
     f.txt_social 1
     f.txt_crace 1
     f.txt_cruiser_race_skipper 1
     f.txt_cruising 1
     f.txt_cruiser_skipper 1
     f.txt_dinghy_sailing 1
     f.txt_junior 1
     f.txt_test 1
     f.txt_op_co 1
     f.occupation 'ruby programmer '
   end
   factory :privilege do |f|
     f.member_class "F"
     f.name "Family"
     f.bar_billies 'Y'
     f.car_park 2
     f.votes 2
     f.bar_reference 1
     f.boat_storage 1 
   end
   factory :boat do |f|
     f.association :member
     f.boat_name "Good Ship Hope"
     f.boat_type "Cruiser"
     f.boat_class "J24"
     f.sail_number "IRL 1234"
     f.pen_tag "K 20"
   end
   factory :member do |f|
     f.proposed "John Doe"
     f.seconded "Jane Doe"
     f.year_joined "2014"
     f.occupation "System Tester"
     f.renew_date "01.01.2014"
     f.privilege_id 1
     #f.association :privilege
     f.name_no "1234"
     f.street1 "Test street name 1"
     f.country "Ireland"
   end
end

#FactoryGirl.define do
#  factory :contact do |f|
#    f.firstname { Faker::Name.first_name }
#    f.lastname { Faker::Name.last_name }
#  end
#end

# F.sequence(:name) {|n| "foo#{n}"}
# f.password "foobar" 
# f.password_confirmation {|u| u.password }
# f.email(:email) { |n| "foo#{n}@example.com"}


