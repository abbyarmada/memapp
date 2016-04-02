# require 'spec_helper'
require 'rails_helper'

describe 'home page' do
  it 'Displays the sign in box' do
    visit '/'
    expect(page).to have_text('Sign in')
    expect(page).to have_text('Email')
    expect(page).to have_text('Password')
  end
end

describe 'login correctly page' do
  it 'confirms successful login', js: true do
    user = FactoryGirl.create(:user)
    visit '/'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Sign in' # this be an Ajax button -- requires Selenium
    expect(page).to have_text('Membership Class')
  end
end
