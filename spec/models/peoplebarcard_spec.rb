require 'rails_helper'

RSpec.describe Peoplebarcard, :type => :model do
  it "has a vaild factory" do
    expect(create(:peoplebarcard)).to be_valid
  end

  it "returns family list of connected barcards" do 
    skip
    member = create(:member)
    person = create(:person, status: 'm',first_name: 'John',member: member)
    partner = create(:person, status: 'p',first_name: 'Jane',member: member)
    barcard1 = create(:barcard)
    barcard2 = create(:barcard)
    personbarcard  = create(:peoplebarcard, person: person) 
    partnerbarcard = create(:peoplebarcard, person: partner)
    expect(Peoplebarcard.familybarcards(member.id)).to eq(member.id)
    #expect(familybarcards(
  end



end
