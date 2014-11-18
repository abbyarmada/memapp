require 'rails_helper'

RSpec.describe "privileges/show", :type => :view do
  before(:each) do
    @privilege = assign(:privilege, Privilege.create!(
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
    expect(rendered).to match(/Member Class/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Bar Billies/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
  end
end
