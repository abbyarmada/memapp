require 'rails_helper'

describe "boats/index", :type => :view do
 before(:each) do
   create(:member,id: 1)
   create(:person,member_id: 1 , first_name: 'John', last_name: 'Doe')
    assign(:boats, [
      build_stubbed(Boat,
        :boat_name => 'Test Boat' ,
        :member_id => 1
      ),
      build_stubbed(Boat,
        :boat_name => 'Good Ship Hope',
        :member_id => 1
      )
    ])
 end
  it "renders a list of boats" do
    allow(view).to receive_messages(:will_paginate => false )
    render
#    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Doe".to_s, :count => 2
    assert_select "tr>td", :text => "John".to_s, :count => 2
    assert_select "tr>td", :text => "Test Boat".to_s, :count => 1
    assert_select "tr>td", :text => "Good Ship Hope".to_s, :count => 1
    assert_select "tr>td", :text => "Cruiser".to_s, :count => 2
    assert_select "tr>td", :text => "J24".to_s, :count => 2
    assert_select "tr>td", :text => "IRL 1234".to_s, :count => 2
    #assert_select "tr>td", :text => "K 20".to_s, :count => 2
   end
end
