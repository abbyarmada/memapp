Feature: new_person

Background:
  Given user is logged in

  Scenario: Add a new person to an existing Membership
    Given I have a "Family" Membership
    Given I am on the people show page
    Then I click button New Person
    Then I should get the New person form
    Then I fill in the New person form
    Then I click button create person
    And  I should have a new person
