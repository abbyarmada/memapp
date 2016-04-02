require 'rails_helper'

describe 'privileges/edit', type: :view do
  before(:each) do
    @privilege = build_stubbed(:privilege)
  end

  it 'renders the edit privilege form' do
    render

    assert_select 'form[action=?][method=?]', privilege_path(@privilege), 'post' do
      assert_select 'input#privilege_member_class[name=?]', 'privilege[member_class]'

      assert_select 'input#privilege_name[name=?]', 'privilege[name]'

      assert_select 'input#privilege_bar_billies[name=?]', 'privilege[bar_billies]'

      assert_select 'input#privilege_car_park[name=?]', 'privilege[car_park]'

      assert_select 'input#privilege_votes[name=?]', 'privilege[votes]'

      assert_select 'input#privilege_bar_reference[name=?]', 'privilege[bar_reference]'

      assert_select 'input#privilege_boat_storage[name=?]', 'privilege[boat_storage]'
    end
  end
end
