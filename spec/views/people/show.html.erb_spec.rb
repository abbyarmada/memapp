require 'rails_helper'



RSpec.describe "people/show", :type => :view do
    before(:each) do
      @privilege = create(:privilege)
      @member = create(:member)
      @people = [ create(:person,:member_id => @member.id),
                  create(:person,:member_id => @member.id,:first_name => 'Jane',:status => 'p')
                ]
      @person = Person.first
    end

    it "renders a membership of main person " do
      allow(view).to receive_messages(:url_for => nil)
      render
      expect(rendered).to match /John/
      expect(rendered).to match /Doe/
      expect(rendered).to match /Jane/
      expect(rendered).to match /Payment/
      expect(rendered).to match /Membership/
      expect(rendered).to match /Personal/
      expect(rendered).to match /Boats/
      expect(rendered).to match /Barcards/
    end
end
