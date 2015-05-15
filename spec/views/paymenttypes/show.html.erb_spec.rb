require 'spec_helper'

describe "paymenttypes/show", :type => :view do
  before(:each) do
    @paymenttype = assign(:paymenttype, stub_model(Paymenttype,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    expect(rendered).to match(/Name/)
  end
end
