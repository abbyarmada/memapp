require 'rails_helper'

RSpec.describe Member, type: :model do
  it 'has a vaild factory' do
    expect(create(:member)).to be_valid
  end
  it 'is invalid without proposed name' do
    expect(build(:member, proposed: nil)).not_to be_valid
  end
  it 'is invalid without proposed name' do
    expect(build(:member, seconded: nil)).not_to be_valid
  end
  it 'is invalid without proposed name' do
    expect(build(:member, seconded: nil)).not_to be_valid
  end
  it 'is invalid without Year Joined' do
    expect(build(:member, year_joined: nil)).not_to be_valid
  end
  it 'is invalid without privilege_id' do
    expect(build(:member, privilege_id: nil)).not_to be_valid
  end
  it 'is invalid without street1' do
    expect(build(:member, street1: nil)).not_to be_valid
  end
  #############################################################
  it 'returns a members main member id' do
    member = create(:member)
    person = create(:person, status: 'm', first_name: 'John', member: member, id: 1)
    partner = create(:person, status: 'p', first_name: 'Jane', member: member)
    expect(member.main_member.id).to eq(1)
  end

  it 'returns a members main member first name' do
    member = create(:member)
    person = create(:person, status: 'm', first_name: 'John', member: member)
    partner = create(:person, status: 'p', first_name: 'Jane', member: member)
    expect(member.main_member.first_name).to eq('John')
  end
end
