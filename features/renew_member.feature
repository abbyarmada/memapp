Feature: member

Background:
  Given user is logged in
  Given I have a "Membership Subscriptions" Payment Type
  Given I have a "Cash" Payment Method

  Scenario: Renew an existing but expired Membership
    Given I have a "Ordinary" Membership
    Given I am on the people show page
    Then I click button New Payment
    Then I fill in the membership renewal form
    Then I click button Create Payment
    Then I should have a new payment
    And the renewal date should be updated
    And the Membership should be set to active
