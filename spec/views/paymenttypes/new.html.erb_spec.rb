require 'rails_helper'

describe 'paymenttypes/new', type: :view do
  before(:each) do
    assign(:paymenttype, stub_model(Paymenttype,
                                    name: 'MyString'
                                   ).as_new_record)
  end

  it 'renders new paymenttype form' do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select 'form[action=?][method=?]', paymenttypes_path, 'post' do
      assert_select 'input#paymenttype_name[name=?]', 'paymenttype[name]'
    end
  end
end
