require 'spec_helper'

describe "privileges/show", :type => :view do
  before(:each) do
    @privilege = assign(:privilege, stub_model(Privilege))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
