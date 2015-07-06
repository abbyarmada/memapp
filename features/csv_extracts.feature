Feature: Bar Interface

Background:
  Given user is logged in

  Scenario: Create and download the Bar interface
    Given I have a "Family" Membership
    And I click on Bar Interface
    Then I should have a family membership
    And I should have a CSV file
