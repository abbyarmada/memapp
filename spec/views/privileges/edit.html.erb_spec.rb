require 'spec_helper'

describe "privileges/edit" do
  before(:each) do
    @privilege = assign(:privilege, stub_model(Privilege))
  end

  it "renders the edit privilege form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", privilege_path(@privilege), "post" do
    end
  end
end
