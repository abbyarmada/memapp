require 'rails_helper'

RSpec.describe Renewal, type: :model do
  it 'has a vaild factory' do
    expect(create(:renewal)).to be_valid
  end
end
