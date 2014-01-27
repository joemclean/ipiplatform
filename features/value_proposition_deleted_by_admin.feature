Feature: Deleting an existing value proposition as an admin

  Background:
    Given an admin account exists
    And I login as an admin
    And a value proposition category and a value proposition exist

  @javascript
  Scenario:  Admin can delete an existing value proposition
    When I visit the admin profile page
    And I go to manage all value propositions
    And I delete the value proposition
    When I go to the general value proposition category index page
    Then I do not see the value proposition

