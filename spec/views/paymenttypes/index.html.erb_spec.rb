require 'rails_helper'

describe "paymenttypes/index" do
  before(:each) do
    assign(:paymenttypes, [
      stub_model(Paymenttype,
        :name => "Name"
      ),
      stub_model(Paymenttype,
        :name => "Name"
      )
    ])
  end

  it "renders a list of paymenttypes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
