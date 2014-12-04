require 'rails_helper'

RSpec.describe "members/show", :type => :view do
  before(:each) do
    @member = create(:member) 
  end

  it "renders attributes in <p>" do
    render
    #skip("Members Show")
    expect(rendered).to match(/Proposed/)
    expect(rendered).to match(/Seconded/)
    expect(rendered).to match(/Name No/)
    expect(rendered).to match(/Street1/)
    expect(rendered).to match(/Street2/)
    expect(rendered).to match(/Town/)
    expect(rendered).to match(/City/)
    expect(rendered).to match(/Postcode/)
    expect(rendered).to match(/County/)
    expect(rendered).to match(/Country/)
    expect(rendered).to match(/Email Renewal/)
    expect(rendered).to match(/Status/)
  end
end
