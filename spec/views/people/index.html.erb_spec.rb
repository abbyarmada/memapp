require 'rails_helper'
require 'will_paginate/array'

describe "people/index" do
  before(:each) do
    @privilege = create(:privilege,id: 1)
    @member    = create(:member,privilege_id: @privilege.id)
    assign(:people, [
      build_stubbed(Person,
       :member_id => @member.id,
       :first_name => 'John',
        :last_name => 'Doe',
        'status' => 'm'
      ),
      build_stubbed(Person,
       :member_id => @member.id,
       :first_name => 'Jane',
       :last_name => 'Doe',
       :status => 'p'
      )
    ])
  end

  it "renders a list of people" do
    allow(view).to receive_messages(:will_paginate => nil)
    render
    assert_select "tr>td", :text => 'John', :count => 1
    assert_select "tr>td", :text => 'Jane', :count => 1
    assert_select "tr>td", :text => 'Family', :count => 2
  end
  end
