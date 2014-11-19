require 'spec_helper'

describe "privileges/index", :type => :view do
  before(:each) do
    assign(:privileges, [
      stub_model(Privilege),
      stub_model(Privilege)
    ])
  end

  it "renders a list of privileges" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
