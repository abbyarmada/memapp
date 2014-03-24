require 'spec_helper'

describe Privilege do
  #pending "add some examples to (or delete) #{__FILE__}"
  
  ########  VALIDATIONS    ######################## 
  it "has a vaild factory" do 
    create(:privilege).should be_valid
  end
  it "is invalid without member_class" do 
    build(:privilege, member_class: nil).should_not be_valid
  end
  it "is invalid without name" do 
    build(:privilege, name: nil).should_not be_valid
  end
  it "is invalid without bar billies" do 
     build(:privilege, bar_billies: '').should_not be_valid
  end
  it "is invalid without votes" do 
    build(:privilege, votes: nil).should_not be_valid
  end
  it "is invalid without car park" do 
    build(:privilege, car_park: nil).should_not be_valid
  end
  it "is invalid without boat storage" do 
    build(:privilege, boat_storage: nil).should_not be_valid
  end
  it "does not allow duplicate member_classes" do 
    create(:privilege, member_class: 'T' )
    build(:privilege,member_class: 'T').should_not be_valid
  end
end
