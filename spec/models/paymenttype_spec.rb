require 'rails_helper'

RSpec.describe Paymenttype, :type => :model do
  it "has a vaild factory" do
    expect(create(:paymenttype)).to be_valid
  end

  it "returns all the paymenttypes names" do 
    p1 = create(:paymenttype)
    p2 = create(:paymenttype, name: 'Pen Fees')
    expect(Paymenttype.types).to eq([p2,p1])
  end
end


