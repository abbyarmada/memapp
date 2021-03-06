require 'rails_helper'

describe 'subscriptions/index' do
  before(:each) do
    create(:privilege, id: 1)
    assign(:subscriptions, [
             build_stubbed(Subscription,
                           amount: 1.5,
                           privilege_id: 1
                          ),
             build_stubbed(Subscription,
                           amount: 1.5,
                           privilege_id: 1
                          )
           ])
  end

  it 'renders a list of subscriptions' do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select 'tr>td', text: 1.5.to_s(:currency, unit: '€'), count: 2
    assert_select 'tr>td', text: 'Family', count: 2
  end
end
