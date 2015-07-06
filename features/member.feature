Feature: member

Background:
  Given user is logged in

  Scenario: Create a new Membership
    Given I have an Applicant member class
    Given I am on the people index page
    Then I click button New Membership
    Then I fill in the form
    Then I click button create Member
    And  I should have a new Membership
