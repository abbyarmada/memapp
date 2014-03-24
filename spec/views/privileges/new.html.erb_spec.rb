require 'spec_helper'

describe "privileges/new" do
  before(:each) do
    assign(:privilege, stub_model(Privilege).as_new_record)
  end

  it "renders new privilege form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", privileges_path, "post" do
    end
  end
end
