require 'spec_helper'

describe "boats/index", :type => :view do
  before(:each) do
    create(:member)
    create(:person)
    create(:privilege)
#    [build_stubbed(:boat, boat_name:"Boat Name" ), build_stubbed(:boat, boat_name:"Boat Name" )]
#    @boats = Boat.members_boats.paginate(:per_page => 30, :page => 1 )
    create(:boat,boat_name: "Boat 1")
    create(:boat,boat_name: "Boat 1")
    @boats = Boat.members_boats.paginate(:per_page => 30, :page => 1 )
  end

  
#  it "renders a list of boats" do
#    render
#    # Run the generator again with the --webrat flag if you want to use webrat matchers
#   # assert_select "tr>td", :text => "Boat Name".to_s, :count => 2
#    assert_select "tr>td", :text => "Boat 1".to_s, :count => 2
#    assert_select "tr>td", :text => "Cruiser".to_s, :count => 2
#    assert_select "tr>td", :text => "J24".to_s, :count => 2
#    assert_select "tr>td", :text => "IRL 1234".to_s, :count => 2
#    assert_select "tr>td", :text => "K 20".to_s, :count => 2
#  end
end
