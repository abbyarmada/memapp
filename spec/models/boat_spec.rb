require 'rails_helper'

describe Boat, :type => :model do
  
    ########  VALIDATIONS    ######################## 
  it "has a vaild factory" do
    build(:person) 
    build(:member)
    expect(create(:boat)).to be_valid
  end
  it "is invalid without type" do
    build(:person)
    build(:member)
    expect(build(:boat, boat_type: "")).not_to be_valid
  end
  it "is invalid without member_id" do 
   #  build(:person)
   # build(:member)
     expect(build(:boat, member_id: nil )).not_to be_valid
  end
  it "is can determine the main member" do 
    member = create(:member,id: 1)
    member.people[0] = create(:person,member_id: 1)
    person = member.people[0]
    boat = create(:boat)
    boat.member = member
    expect(boat.owner).to eq (person)
  end
end
