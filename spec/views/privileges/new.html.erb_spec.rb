require 'rails_helper'

RSpec.describe "privileges/new", :type => :view do
  before(:each) do
    assign(:privilege, Privilege.new(
      :member_class => "MyString",
      :name => "MyString",
      :bar_billies => "MyString",
      :car_park => 1,
      :votes => 1,
      :bar_reference => 1,
      :boat_storage => 1
    ))
  end

  it "renders new privilege form" do
    render

    assert_select "form[action=?][method=?]", privileges_path, "post" do

      assert_select "input#privilege_member_class[name=?]", "privilege[member_class]"

      assert_select "input#privilege_name[name=?]", "privilege[name]"

      assert_select "input#privilege_bar_billies[name=?]", "privilege[bar_billies]"

      assert_select "input#privilege_car_park[name=?]", "privilege[car_park]"

      assert_select "input#privilege_votes[name=?]", "privilege[votes]"

      assert_select "input#privilege_bar_reference[name=?]", "privilege[bar_reference]"

      assert_select "input#privilege_boat_storage[name=?]", "privilege[boat_storage]"
    end
  end
end
