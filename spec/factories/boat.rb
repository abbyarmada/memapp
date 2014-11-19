FactoryGirl.define do
  require 'faker'
  factory :boat do |f|
     #member
     f.member_id 1
     f.boat_name "Good Ship Hopeless"
     f.boat_type "Cruiser"
     f.boat_class "J24"
     f.sail_number "IRL 1234"
     f.pen_tag "K 20"
   end
end