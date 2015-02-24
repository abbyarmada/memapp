require 'rails_helper'

RSpec.describe "members/index", :type => :view do
  before(:each) do
   #create(:privilege)
    create(:member)
    create(:member)
  end

  it "renders a list of members" do
    render
    assert_select "tr>th", :text => "Proposed".to_s, :count => 1
  #  assert_select "tr>td", :text => "Seconded".to_s, :count => 2
  #  assert_select "tr>td", :text => 2014.to_s, :count => 2
  #  assert_select "tr>td", :text => '2014-01-01 10:38:10'.to_s, :count => 2
  #  assert_select "tr>td", :text => "Name No".to_s, :count => 2
  #  assert_select "tr>td", :text => "Street1".to_s, :count => 2
  #  assert_select "tr>td", :text => "Street2".to_s, :count => 2
  #  assert_select "tr>td", :text => "Town".to_s, :count => 2
  #  assert_select "tr>td", :text => "City".to_s, :count => 2
  #  assert_select "tr>td", :text => "Postcode".to_s, :count => 2
  #  assert_select "tr>td", :text => "County".to_s, :count => 2
  #  assert_select "tr>td", :text => "Country".to_s, :count => 2
  #  assert_select "tr>td", :text => "Email Renewal".to_s, :count => 2
  end
end
