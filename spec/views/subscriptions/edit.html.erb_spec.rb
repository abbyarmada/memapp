require 'rails_helper'

describe 'subscriptions/edit' do
  before(:each) do
    @subscription = assign(:subscription, stub_model(Subscription,
                                                     amount: 1.5,
                                                     privilege_id: 1
                                                    ))
  end

  it 'renders the edit subscription form' do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select 'form[action=?][method=?]', subscription_path(@subscription), 'post' do
      assert_select 'input#subscription_amount[name=?]', 'subscription[amount]'
      assert_select 'select#subscription_privilege_id[name=?]', 'subscription[privilege_id]'
    end
  end
end
