require 'rails_helper'

describe Boat do
  
    ########  VALIDATIONS    ######################## 
  it "has a vaild factory" do
    build(:person) 
    build(:member)
    create(:boat).should be_valid
  end
  it "is invalid without type" do
    build(:person)
    build(:member)
    build(:boat, boat_type: "").should_not be_valid
  end
  it "is invalid without member_id" do 
   #  build(:person)
   # build(:member)
     build(:boat, member_id: nil ).should_not be_valid
  end
end
