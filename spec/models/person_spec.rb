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
  #TODO investiget this and accepts nested attributes..
  # it "is invalid without member_id" do
 #    expect(build(:person, member_id: nil)).not_to be_valid
 # end
   it "is invalid to have a duplicate main member within a single membership" do
    create(:person)
    expect(build(:person,  status: 'm', member_id: 1)).not_to be_valid
  end
  it "is invalid to have a duplicate partner member within a single membership" do
    create(:person)
    create(:person,  status: 'p', member_id: 1)
    expect(build(:person,  status: 'p', member_id: 1)).not_to be_valid
  end
  #it "is invalid to have any status member without a main member within a single membership" do
  #  skip "erroring person status m "
  #  expect(build(:person,  status: 'p', member_id: 1)).not_to be_valid
  #end
  #FIXME test above is broken
  #### instance tests ############
  it "returns a Person's full name as a string" do
    person = create(:person, first_name: "John", last_name: "Doe")
    expect(person.salutation).to eq("John Doe")
  end
  it "Determines if a person is a main member" do
    person = create(:person)
    expect(person.main_person?).to eq(true)
  end
  it "Determines a persons partner" do
    person =  create(:person)
    partner = create(:person, first_name: "Jane", status: 'p',member_id: person.member_id )
    expect(person.partner.member_id).to eq(person.member_id)
  end
   it "is valid to have a missing age" do
     person = create(:person, dob:nil )
     expect(person.age).to be_nil
  end
  it "Age is calculated correctly" do
    person = create(:person, dob: (Date.today - 10.year))
    expect(person.age).to eq(10)
  end
  it "Determins an adult correctly" do
    person = create(:person, dob: (Date.today - 18.year))
    expect(person.adult?).to eq(true)
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
  it "returns a Person's Caption" do
    person = create(:person, first_name: "John", last_name: "Doe")
    expect(person.caption).to eq("Doe, John")
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
  it "Counts the number of active members - no past members" do
    privilege = create(:privilege) 
    member = create(:member, privilege: privilege) 
    person = create(:person,member: member) 
    expect(Person.current.count).to eq(1)
    expect(Person.past.count).to eq(0) 
    expect(Person.not_renewed.count).to eq(0)    
  end
  it "Counts the number of active members - 1 not renewed member" do
    privilege = create(:privilege)
    member = create(:member, privilege: privilege, active: false, renew_date: 1.year.ago ) 
    person = create(:person,member: member)
    expect(Person.current.count).to eq(0)
    expect(Person.past.count).to eq(1)
    expect(Person.not_renewed.count).to eq(1)
  end
  it "Counts the number of members - 1 past member" do
    privilege = create(:privilege)
    member = create(:member, privilege: privilege, active: false, renew_date: 2.years.ago )
    person = create(:person,member: member)
    expect(Person.current.count).to eq(0)
    expect(Person.past.count).to eq(1)
    expect(Person.not_renewed.count).to eq(0)
  end
  it "Finds the member last name beginning 'Sm'" do
    privilege = create(:privilege)
    member = create(:member, privilege: privilege, active: true )
    person = create(:person,member: member, last_name: "Smith")
    expect(Person.search(search: "Sm").count).to eq(1)
    expect(Person.search(search: "sm").count).to eq(1)
  end
  it "Finds the member last name beginning 'Sm' if past member " do
    privilege = create(:privilege)
    member = create(:member, privilege: privilege, active: false, renew_date: 2.years.ago )
    person = create(:person,member: member, last_name: "Smith")
    expect(Person.search(search: "Sm",past_members: true).count).to eq(1)
    expect(Person.search(search: "sm",past_members: true).count).to eq(1)
  end
  it "Finds the member Last name beginning 'Sm' if not renewed member" do
   skip "#FIXME"
    privilege = create(:privilege)
    member = create(:member, privilege: privilege, active: false, renew_date: 1.year.ago )
    person = create(:person,member: member)
    expect(Person.search(search: "Sm",not_renewed: true, past_members: true).count).to eq(1)
    expect(Person.search(search: "sm",not_renewed: true, past_members: true).count).to eq(1)
  end






  # it "Determines if a main member is missing" do 
  #  expect{ (create(:person, status: "p")) }.to raise_error
  # end
end

