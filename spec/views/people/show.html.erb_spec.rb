require 'rails_helper'



RSpec.describe "people/show", :type => :view do
    before(:each) do
      privilege = build_stubbed(:privilege)
      member = build_stubbed(:member,privilege: privilege)
      @people = [ create(:person,:member => member),
                  create(:person,:member => member ,:first_name => 'Jane',:status => 'p')
                ]
      @person = @people[0]
    end

    it "renders a membership of main person " do
      allow(view).to receive_messages(:url_for => false )
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
