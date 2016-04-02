Given(/^I have a "(.*?)" Payment Type$/) do |name|
  FactoryGirl.create(:paymenttype, name: name)
end

Given(/^I have a "(.*?)" Payment Method$/) do |name|
  FactoryGirl.create(:payment_method, name: name)
end

Then(/^I click button New Payment$/) do
  click_link 'New Payment'
end

Then(/^I fill in the membership renewal form$/) do
  select  'Membership Subscriptions', from: 'Payment Type'
  fill_in 'Amount', with: 380
  select  'Ordinary', from: 'Member Class'
  select  'Cash', from: 'Payment method'
  #  select_date("Date lodged", with: Time.now.strftime("%F") )
  # taking the default date!
  fill_in 'Comment', with: 'Testing '
end

Then(/^I click button Create Payment$/) do
  click_button 'Create Payment'
end

Then(/^I should have a new payment$/) do
  @member.payments.count == 1
end

Then(/^the renewal date should be updated$/) do
  @member.renew_date = Date.today
end

Then(/^the Membership should be set to active$/) do
  @member.active == true
end
