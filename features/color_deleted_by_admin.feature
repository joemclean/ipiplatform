Feature: Deleting an existing color as an admin

  Background:
    Given an admin account exists
    And I login as an admin
    And a value proposition category and a color exist

  @javascript
  Scenario:  Admin can delete an existing color
    When I visit the admin profile page
    And I go to manage colors
    And I delete the color
    When I go to the general value proposition category index page
    Then I do not see the color

