require 'rails_helper'

RSpec.describe "privileges/index", :type => :view do
  before(:each) do
    assign(:privileges, [
      Privilege.create!(
        :member_class => "F",
        :name => "Class 1",
        :bar_billies => "Y",
        :car_park => 1,
        :votes => 2,
        :bar_reference => 3,
        :boat_storage => 4
      ),
      Privilege.create!(
        :member_class => "T",
        :name => "Class 2",
        :bar_billies => "Y",
        :car_park => 1,
        :votes => 2,
        :bar_reference => 3,
        :boat_storage => 4
      )
    ])
  end

  it "renders a list of privileges" do
    render
    assert_select "tr>td", :text => "F".to_s, :count => 1
    assert_select "tr>td", :text => "T".to_s, :count => 1
    assert_select "tr>td", :text => "Class".to_s, :count => 2
    assert_select "tr>td", :text => "Y".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
  end
end
