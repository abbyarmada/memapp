require 'rails_helper'

describe 'people/edit', type: :view do
  let(:privilege) { build_stubbed(:privilege) }
  let(:member) { build_stubbed(:member) }
  it 'renders a membership of main person ' do
    @people = [create(:person, member_id: member.id), build_stubbed(:person, member_id: member.id, first_name: 'Jane', status: 'p')]
    @person = Person.first # @people[0]
    #    allow(view).to receive_messages(:url_for => nil)
    render
    expect(rendered).to match(/Personal Details/)
    expect(rendered).to match(/Contact Details/)
    expect(rendered).to match(/Subscribed Lists/)
  end
end
