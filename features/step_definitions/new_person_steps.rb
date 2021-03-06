# features/step_definitions/home_page_steps.rb
Given(/^I have a Family2 Membership$/) do
  @member = FactoryGirl.create(:member,
                               people: [FactoryGirl.create(:person),
                                        FactoryGirl.create(:person,
                                                           status: :p, first_name: 'jane')],
                               privilege: FactoryGirl.create(:privilege))
  @person = @member.people.first
  @partner = @member.people.last
  @member.complete_new_member_process
end

Given(/^I am on the people show page$/) do
  visit person_path(@member.main_member)
  # save_page
end

Then(/^I click button New Person$/) do
  click_link 'New Person'
  # save_page #save_and_open_page
end

Then(/^I should get the New person form$/) do
  page.should have_content('New person')
end

Then(/^I fill in the New person form$/) do
  fill_in 'First Name', with: 'John'
  fill_in 'Last Name',  with: 'Doe'
  select('Child of main member')
  save_page
end

Then(/^I click button create person$/) do
  click_on 'Create Person'
  save_page
end

Then(/^I should have a new person$/) do
  expect(@member.people.count).to eq(3)
end
