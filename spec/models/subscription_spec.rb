require 'rails_helper'

RSpec.describe Subscription, :type => :model do
  it "has a vaild factory" do
    expect(create(:subscription)).to be_valid
  end
end
