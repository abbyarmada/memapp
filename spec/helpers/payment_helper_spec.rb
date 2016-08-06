require 'rails_helper'
include PaymentHelper
RSpec.describe PaymentHelper, type: :helper do
  it 'Determines the member classses' do
    years = 2
    types = [{ 'a' => 10, 'b' => 20, 'c' => 30 }, { 'd' => 10, 'e' => 20, 'f' => 30 }]
    response = described_class.member_classes(years, types)
    expect(response).to eq(%w(a b c d e f))
  end
  it 'Determines the graph data and url' do
    allow(helper).to receive(:params).and_return(date: { month: '4' })
    response = described_class.g_chart_mems('12', '31')
    expected = 'http://chart.apis.google.com/chart?chs=600x200&cht=lc&chco=0000ff,ff0000,008000,ffd700,ffa500&chxt=y,x&chxl=1:|&chxr=0,0,100&chxs=0,10,0|1,10,0&chd=s:,,,,&chm=o,0000ff,0,-1,10|o,ff0000,1,-1,10|o,008000,2,-1,10|o,FFd700,3,-1,10|o,FFa500,4,-1,10&chdl=2016|2015|2014|2013|2012&chtt=Membership+Trends,+Year+To+December+31'
    expect(response).to eq(expected)
  end
end
