FactoryGirl.define do
  factory :member do
    #privilege
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
	active 1
    factory :member_with_main_person do
      after(:create) do |member|
        create(:person, status: 'm',member: member)
      end
    end
    factory :member_with_main_person_and_partner do
      after(:create) do |member|
        create(:person, status: 'm', member: member)
        create(:person, status: 'p', member: member)
      end
    end
  end
end