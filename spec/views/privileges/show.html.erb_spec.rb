require 'rails_helper'

describe "privileges/show", :type => :view do
  before(:each) do
    @privilege = assign(:privilege, Privilege.create!(
      :member_class => "Member Class",
      :name => "Name",
      :bar_billies => "Y",
      :car_park => 1,
      :votes => 2,
      :bar_reference => 3,
      :boat_storage => 4
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Member class/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Bar billies/)
    expect(rendered).to match(/Car park/)
    expect(rendered).to match(/Votes/)
    expect(rendered).to match(/Bar reference/)
    expect(rendered).to match(/Boat storage/)
  end
end
