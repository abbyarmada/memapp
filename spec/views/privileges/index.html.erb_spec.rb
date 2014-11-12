require 'spec_helper'

describe "privileges/index" do
  before(:each) do
    assign(:privileges, [
      stub_model(Privilege,
        :member_class => "Member Class",
        :name => "Name",
        :bar_billies => "Bar Billies",
        :car_park => 1,
        :votes => 2,
        :bar_reference => 3,
        :boat_storage => 4
      ),
      stub_model(Privilege,
        :member_class => "Member Class",
        :name => "Name",
        :bar_billies => "Bar Billies",
        :car_park => 1,
        :votes => 2,
        :bar_reference => 3,
        :boat_storage => 4
      )
    ])
  end

  it "renders a list of privileges" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Member Class".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Bar Billies".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
  end
end
