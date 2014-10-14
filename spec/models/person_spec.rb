require 'spec_helper'

describe Person do
  #pending "add some examples to (or delete) #{__FILE__}"
   before(:each) do
    build_stubbed(:member)
    build_stubbed(:privilege)
  end
  ########  VALIDATIONS    ######################## 
  it "has a vaild factory" do 
    create(:person).should be_valid
  end
  it "is invalid without first_name" do 
    build(:person, first_name: nil).should_not be_valid
  end
  it "is invalid without last_name" do 
    build(:person, last_name: nil).should_not be_valid
  end
  it "is invalid without member_id" do 
     build(:person, member_id: nil).should_not be_valid
  end
   it "is invalid to have a duplicate main member within a single membership" do
    create(:person)
    build(:person,  status: 'm', member_id: 1).should_not be_valid
  end
  it "is invalid to have a duplicate partner member within a single membership" do
    create(:person)
    create(:person,  status: 'p', member_id: 1)
    build(:person,  status: 'p', member_id: 1).should_not be_valid
  end
  it "is invalid to have any status member without a main member within a single membership" do
    create(:person,  status: 'p', member_id: 1).should_not be_valid
  end
  #### instance tests ############ 
  it "returns a Person's full name as a string" do
    person = create(:person, first_name: "John", last_name: "Doe")
    person.salutation.should == "John Doe"
  end
   it "is valid to have a missing age" do
     person = create(:person, dob:nil )
     person.age.should be_nil
  end
  it "Age is calculated correctly" do
    person = create(:person, dob:(Date.today - 10.year) )
     person.age.should == 10 
  end
  it "returns a person's first name and partner first name as salutation when surnames match" do 
    person = create(:person, first_name: "John", last_name: "Doe")
    create(:person, first_name: "Jane", last_name: "Doe", status: 'p',member_id: 1 )
    person.salutation.should == "John & Jane Doe"
  end
  it "returns a person's fist name surname and partner name and surname as salutation" do 
    person = create(:person, first_name: "John", last_name: "Doe")
    create(:person, first_name: "Jane", last_name: "Does", status: 'p', member_id: 1)
    person.salutation.should == "John Doe & Jane Does"
  end
  it "Child should not have partners name as salutation name " do 
    create(:person, first_name: "John", last_name: "Doe")
    create(:person, first_name: "Jane", last_name: "Does", status: 'p', member_id: 1)
    person = create(:person, first_name: "Jimmy", last_name: "Doe", status: 'c', member_id: 1)
    person.salutation.should == "Jimmy Doe"
  end
    it "returns a Person's first name for Salutation" do
    person = create(:person, first_name: "John", last_name: "Doe")
    person.salutation_first_names.should == "John"
  end
    it "returns a Person's & Partners first name for Salutation" do
    person = create(:person, first_name: "John", last_name: "Doe")
    create(:person, first_name: "Jane", last_name: "Does", status: 'p', member_id: 1)
    person.salutation_first_names.should == "John & Jane"
  end
  it "returns a Person's & Partners first name for Salutation - But not for the partner! " do
    create(:person, first_name: "John", last_name: "Doe")
    person = create(:person, first_name: "Jane", last_name: "Does", status: 'p', member_id: 1)
    person.salutation.should_not == "Jane & Jane Does"
  end
end
