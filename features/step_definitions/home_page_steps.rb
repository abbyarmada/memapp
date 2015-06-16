# features/step_definitions/home_page_steps.rb
Given(/^there's a person with first_name "(.*?)" and  last_name "(.*?)"$/) do |first_name, last_name|
  #pending # express the regexp above with the code you wish you had
  #@person = FactoryGirl.create(:person, first_name: first_name, last_name: last_name)

 #@privilege = FactoryGirl.create(:privilege)
  @member =  FactoryGirl.create(:member,:people => [FactoryGirl.create(:person) ], :privilege => FactoryGirl.create(:privilege) )
  @person = @member.people.first
  @member.complete_new_member_process
end

When(/^I am on the homepage$/) do
  visit root_path
  save_page #save_and_open_page
end

Then(/^I should see the person with first_name "(.*?)" and  last_name "(.*?)"$/) do |first_name, last_name|
  @person = Person.find_by first_name: first_name

  page.should have_content(@person.first_name)
  page.should have_content(@person.last_name)
end

Given(/^user is logged in$/) do
#  pending # express the regexp above with the code you wish you had
  @user = FactoryGirl.create(:user)
  visit '/users/sign_in'
  fill_in "user_email", :with => @user.email
  fill_in "user_password", :with => @user.password
  click_button "Sign in"
end