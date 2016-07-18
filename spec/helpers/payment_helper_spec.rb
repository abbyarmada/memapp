require 'rails_helper'
include PaymentHelper
RSpec.describe PaymentHelper, type: :helper do
  it 'Determines the member classses' do
    years = 2
    types = [{ 'a' => 10, 'b' => 20, 'c' => 30 }, { 'd' => 10, 'e' => 20, 'f' => 30 }]
    response = described_class.member_classes(years, types)
    expect(response).to eq(%w(a b c d e f))
  end
  it 'Determines ' do
    years = 2
    types = [{ 'a' => 10, 'b' => 20, 'c' => 30 }, { 'd' => 10, 'e' => 20, 'f' => 30 }]
    # Payment.stub(:params).with( date: { month: '4' })
    # helper.stub(:params).and_return(date: { month: '4' })
    # #{ date: { month: '4' } }
    # params[:date] = { month: '4' }
    # assigns[:date][:month] = 5
    allow(helper).to receive(:params).and_return(date: { month: '4' })
    response = described_class.g_chart_mems
    expect(response).to eq(%w(a b c d e f))
  end
end
