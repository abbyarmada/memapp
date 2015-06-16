require 'rails_helper'

RSpec.describe "people/edit", :type => :view do
  before(:each) do
    @privilege = build_stubbed(:privilege)
    @member = build_stubbed(:member)
    @people = [ build_stubbed(:person,:member_id => @member.id),
              #  build_stubbed(:person,:member_id => @member.id,:first_name => 'Jane',:status => 'p')
              ]
    @person = @people[0]
  end
  it "renders a membership of main person " do
  #    allow(view).to receive_messages(:url_for => nil)
      render
      expect(rendered).to match /Personal Details/
      expect(rendered).to match /Contact Details/
      expect(rendered).to match /Subscribed Lists/

  end

end
