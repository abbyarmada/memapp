require 'rails_helper'

RSpec.describe Subscription, type: :model do
  it 'has a vaild factory' do
    expect(create(:subscription)).to be_valid
  end
  it 'can determine the rate for this year' do
    date = DateTime.now.utc
    create(:subscription, start_date: date, end_date: date, amount: 200.00)
    expect(described_class.subscription_for_year(date)).to eq(200)
  end
end
