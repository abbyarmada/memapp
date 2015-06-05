Feature: Home page

Background:
  Given user is logged in

  Scenario: Viewing application's home page
    Given I have an Applicant member class
    Given there's a person with first_name "John" and  last_name "Doe"
    When I am on the homepage
    Then I should see the person with first_name "John" and  last_name "Doe"
