FactoryGirl.define do
  factory :boat do
    # member
    member_id 1
    boat_name 'Good Ship Hopeless'
    boat_type 'Cruiser'
    boat_class 'J24'
    sail_number 'IRL 1234'
    pen_tag 'K 20'
    # factory :boat_with_member_and_main_person do
    #  after(:create) do |member|
    #    create(:person, status: 'm')
    #  end
    # end
    # factory :boat_with_member_and_main_person do
    #   after(:create) do |boat|
    #     create(:member_with_main_person )
    #   end
    # end
  end
end
#= create(:person)
# member = create(:member, :people => [ person ] )
# create(:member)#.association member_with_1_person factory:  :member
