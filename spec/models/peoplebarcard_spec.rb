require 'rails_helper'

RSpec.describe Peoplebarcard, :type => :model do
  it "has a vaild factory" do
    expect(create(:peoplebarcard)).to be_valid
  end
end
