require 'rails_helper'

describe "paymenttypes/show" do
  before(:each) do
    @paymenttype = assign(:paymenttype, stub_model(Paymenttype,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
