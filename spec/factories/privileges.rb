FactoryGirl.define do
  factory :privilege do |f|
    f.member_class "F"
    f.name "Family"
    f.bar_billies 'Y'
    f.car_park 2
    f.votes 2
    f.bar_reference 1
    f.boat_storage 1
  end
end
