require 'rails_helper'

describe "paymenttypes/edit" do
  before(:each) do
    @paymenttype = assign(:paymenttype, stub_model(Paymenttype,
      :name => "MyString"
    ))
  end

  it "renders the edit paymenttype form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", paymenttype_path(@paymenttype), "post" do
      assert_select "input#paymenttype_name[name=?]", "paymenttype[name]"
    end
  end
end
