FactoryGirl.define do
  factory :member do
    proposed "Proposed"
    seconded "Seconded"
    year_joined 2014
    renew_date "2014-01-01 10:38:10"
    privilege_id 1
    name_no "Apt 123"
    street1 "Street 1"
    street2 "Street 2"
    town "Town"
    city "City"
    postcode "Postcode"
    county "County"
    country "Country"
    email_renewal "Y"
  end
#  factory :invalid_member, parent: :member do 
#    proposed ""
#  end
end
