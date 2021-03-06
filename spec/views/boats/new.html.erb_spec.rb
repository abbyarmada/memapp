require 'rails_helper'

describe 'boats/new', type: :view do
  before(:each) do
    create(:member, id: 1)
    create(:person, member_id: 1)
    assign(:boat, stub_model(Boat,
                             boat_name: 'Test Boat',
                             member_id: 1).as_new_record)
  end
  it 'renders new boat form' do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select 'form[action=?][method=?]', boats_path, 'post' do
      assert_select 'input#boat_member_id[name=?]', 'boat[member_id]'
      assert_select 'input#boat_boat_name[name=?]', 'boat[boat_name]'
      assert_select 'select#boat_boat_type[name=?]', 'boat[boat_type]'
      assert_select 'input#boat_boat_class[name=?]', 'boat[boat_class]'
      assert_select 'input#boat_sail_number[name=?]', 'boat[sail_number]'
      assert_select 'input#boat_pen_tag[name=?]', 'boat[pen_tag]'
    end
  end
end
