require 'rails_helper'

RSpec.describe Barcard, type: :model do
  it 'has a vaild factory' do
    expect(create(:barcard)).to be_valid
  end
end
