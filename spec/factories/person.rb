FactoryGirl.define do
   factory :person do |f|
     #member
     f.member_id 1
     f.first_name 'John'
     f.last_name 'Doe'
     f.status 'm'
     f.child_dob ''
     f.home_phone '01-845-1234'
     f.email_address 'john.doe@testmail.com'
     f.comm_prefs ''
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
     f.send_txt 1
     f.send_email 1
     f.mobile_phone '12345'
   end
end
