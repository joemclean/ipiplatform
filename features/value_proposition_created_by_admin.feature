Feature: Creating new value proposition as an admin

  Background:
    Given an admin account exists
    And I login as an admin
    And a value proposition category exists

 @javascript
  Scenario: Admin can create a new value proposition
    When I visit the admin profile page
    When I go to manage value propositions
    When I create a new value proposition
    When I fill in all required value proposition fields
    When I save the new value proposition
    When I go to the general value proposition index page
    Then I see the value proposition I just created
