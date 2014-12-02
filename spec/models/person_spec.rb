require 'rails_helper'

describe Person, :type => :model do
  #pending "add some examples to (or delete) #{__FILE__}"
   #before(:each) do
   # build_stubbed(:member)
  #  build_stubbed(:privilege)
  #end
  ########  VALIDATIONS    ########################
  it "has a vaild factory" do
    expect(create(:person)).to be_valid
  end
  it "is invalid without first_name" do
    expect(build(:person, first_name: nil)).not_to be_valid
  end
  it "is invalid without last_name" do
    expect(build(:person, last_name: nil)).not_to be_valid
  end
  it "is invalid without member_id" do
     expect(build(:person, member_id: nil)).not_to be_valid
  end
   it "is invalid to have a duplicate main member within a single membership" do
    create(:person)
    expect(build(:person,  status: 'm', member_id: 1)).not_to be_valid
  end
  it "is invalid to have a duplicate partner member within a single membership" do
    create(:person)
    create(:person,  status: 'p', member_id: 1)
    expect(build(:person,  status: 'p', member_id: 1)).not_to be_valid
  end
  it "is invalid to have any status member without a main member within a single membership" do
    skip "erroring person status m "
    expect(build(:person,  status: 'p', member_id: 1)).not_to be_valid
  end
  #### instance tests ############
  it "returns a Person's full name as a string" do
    person = create(:person, first_name: "John", last_name: "Doe")
    expect(person.salutation).to eq("John Doe")
  end
   it "is valid to have a missing age" do
     person = create(:person, dob:nil )
     expect(person.age).to be_nil
  end
  it "Age is calculated correctly" do
    person = create(:person, dob:(Date.today - 10.year) )
     expect(person.age).to eq(10) 
  end
  it "returns a person's first name and partner first name as salutation when surnames match" do 
    person = create(:person, first_name: "John", last_name: "Doe")
    create(:person, first_name: "Jane", last_name: "Doe", status: 'p',member_id: 1 )
    expect(person.salutation).to eq("John & Jane Doe")
  end
  it "returns a person's fist name surname and partner name and surname as salutation" do 
    person = create(:person, first_name: "John", last_name: "Doe")
    create(:person, first_name: "Jane", last_name: "Does", status: 'p', member_id: 1)
    expect(person.salutation).to eq("John Doe & Jane Does")
  end
  it "Child should not have partners name as salutation name " do
    create(:person, first_name: "John", last_name: "Doe")
    create(:person, first_name: "Jane", last_name: "Does", status: 'p', member_id: 1)
    person = create(:person, first_name: "Jimmy", last_name: "Doe", status: 'c', member_id: 1)
    expect(person.salutation).to eq("Jimmy Doe")
  end
    it "returns a Person's first name for Salutation" do
    person = create(:person, first_name: "John", last_name: "Doe")
    expect(person.salutation_first_names).to eq("John")
  end
    it "returns a Person's & Partners first name for Salutation" do
    person = create(:person, first_name: "John", last_name: "Doe")
    create(:person, first_name: "Jane", last_name: "Does", status: 'p', member_id: 1)
    expect(person.salutation_first_names).to eq("John & Jane")
  end
  it "returns a Person's & Partners first name for Salutation - But not for the partner! " do
    create(:person, first_name: "John", last_name: "Doe")
    person = create(:person, first_name: "Jane", last_name: "Does", status: 'p', member_id: 1)
    expect(person.salutation).not_to eq("Jane & Jane Does")
  end
  it "returns a Memberships main person  " do
    person = create(:person, status: 'm', member_id: 1)
    create(:person, status: 'p', member_id: 1)
    expect(person.main_member).to eq(person)
  end
end
