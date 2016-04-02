require 'rails_helper'

describe 'people/index' do
  before(:each) do
    privilege = build_stubbed(:privilege)
    member    = build_stubbed(:member, privilege: privilege)
    assign(:people, [
             build_stubbed(Person,
                           :member => member,
                           :first_name => 'John',
                           :last_name => 'Doe',
                           'status' => 'm'
                          ),
             build_stubbed(Person,
                           member: member,
                           first_name: 'Jane',
                           last_name: 'Doe',
                           status: 'p'
                          )
           ])
  end

  it 'renders a list of people' do
    allow(view).to receive_messages(will_paginate: false)
    render
    assert_select 'tr>td', text: 'John', count: 1
    assert_select 'tr>td', text: 'Jane', count: 1
    assert_select 'tr>td', text: 'Family', count: 2
  end
end
