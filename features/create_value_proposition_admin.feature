Feature: Creating new value propositions as an admin

  Background:
    Given an admin account exists
    And I login as an admin

  Scenario: Admin can create a value proposition
    When I visit the admin profile page
    And I go to manage value propositions
    And I create a new value proposition
    And I fill in all required value proposition fields
    And I save the new value proposition
    And I go to the general value proposition index page
    Then I see the value proposition I just created
