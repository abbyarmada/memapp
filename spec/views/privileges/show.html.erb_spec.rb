require 'rails_helper'

describe "privileges/show" do
  before(:each) do
    @privilege = assign(:privilege, stub_model(Privilege,
      :member_class => "Member Class",
      :name => "Name",
      :bar_billies => "Bar Billies",
      :car_park => 1,
      :votes => 2,
      :bar_reference => 3,
      :boat_storage => 4
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Member Class/)
    rendered.should match(/Name/)
    rendered.should match(/Bar Billies/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/4/)
  end
end
