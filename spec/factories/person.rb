FactoryGirl.define do
  require 'faker'
   factory :person do |f|
     #member
     f.member_id 1
     f.first_name  { Faker::Name.first_name }
     f.last_name { Faker::Name.last_name }
     f.status 'm'
     f.child_dob ''
     f.home_phone '01-845-1234'
     f.email_address { Faker::Internet.email }
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
end