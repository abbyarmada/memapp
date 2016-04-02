require 'rails_helper'

describe Boat, type: :model do
  ########  VALIDATIONS    ########################
  it 'has a vaild factory' do
    expect(create(:boat)).to be_valid
  end
  it 'is invalid without type' do
    expect(build(:boat, boat_type: '')).not_to be_valid
  end
  it 'is invalid without member_id' do
    expect(build(:boat, member_id: nil)).not_to be_valid
  end
  ###########   Associations  ###########################
  it 'is can determine the main member' do
    person = create(:person)
    member = build_stubbed(:member, people: [person])
    boat = create(:boat, member: member)
    # boat = create(:boat_with_member_and_main_person)
    expect(boat.owner.id).to eq boat.member.people[0].id
  end
end
