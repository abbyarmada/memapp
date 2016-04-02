require 'rails_helper'

describe Privilege, type: :model do
  ########  VALIDATIONS    ########################
  it 'has a vaild factory' do
    expect(create(:privilege)).to be_valid
  end
  it 'is invalid without member_class' do
    expect(build(:privilege, member_class: nil)).not_to be_valid
  end
  it 'is invalid without name' do
    expect(build(:privilege, name: nil)).not_to be_valid
  end
  it 'is invalid without bar billies' do
    expect(build(:privilege, bar_billies: '')).not_to be_valid
  end
  it 'is invalid without votes' do
    expect(build(:privilege, votes: nil)).not_to be_valid
  end
  it 'is invalid without car park' do
    expect(build(:privilege, car_park: nil)).not_to be_valid
  end
  it 'is invalid without boat storage' do
    expect(build(:privilege, boat_storage: nil)).not_to be_valid
  end
  it 'does not allow duplicate member_classes' do
    create(:privilege, member_class: 'T')
    expect(build(:privilege, member_class: 'T')).not_to be_valid
  end
end
