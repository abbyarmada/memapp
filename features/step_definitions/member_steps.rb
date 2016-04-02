Given(/^I have an Applicant member class$/) do
  FactoryGirl.create(:privilege, name: :Applicant)
end

Given(/^I am on the people index page$/) do
  visit people_path
end

Then(/^I click button New Membership$/) do
  click_link 'New Membership'
end

Then(/^I fill in the form$/) do
  fill_in 'First Name', with: 'John'
  fill_in 'Last Name',  with: 'Doe'
  fill_in 'Proposed', with: 'Proposer'
  fill_in 'Seconded', with: 'Seconder'
  fill_in 'Street1', with: 'Test Street1'
  # save_page
end

Then(/^I click button create Member$/) do
  click_button 'Create Member'
  # save_page
end

Then(/^I should have a new Membership$/) do
  @person = Person.first
  page.should have_content('Member was successfully created')
  page.should have_content('John')
  page.should have_content('Doe')
  @person.first_name.should eq('John')
  # @person.peoplebarcard.id.should eq(1)
  # @person.barcard.id.should eq(1)
end
