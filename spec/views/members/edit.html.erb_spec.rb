require 'rails_helper'

RSpec.describe 'members/edit', type: :view do
  before(:each) do
    @member = create(:member)
  end

  it 'renders the edit member form' do
    render

    assert_select 'form[action=?][method=?]', member_path(@member), 'post' do
      assert_select 'input#member_proposed[name=?]', 'member[proposed]'
      assert_select 'input#member_seconded[name=?]', 'member[seconded]'
      assert_select 'select#member_privilege_id[name=?]', 'member[privilege_id]'
      assert_select 'input#member_name_no[name=?]', 'member[name_no]'
      assert_select 'input#member_street1[name=?]', 'member[street1]'
      assert_select 'input#member_street2[name=?]', 'member[street2]'

      assert_select 'input#member_town[name=?]', 'member[town]'

      assert_select 'input#member_city[name=?]', 'member[city]'

      assert_select 'input#member_postcode[name=?]', 'member[postcode]'

      assert_select 'input#member_county[name=?]', 'member[county]'

      assert_select 'select#member_country[name=?]', 'member[country]'

      assert_select 'input#member_email_renewal[name=?]', 'member[email_renewal]'
    end
  end
end
