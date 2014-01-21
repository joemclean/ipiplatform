Feature: Editing new color as an admin

  Background:
    Given an admin account exists
    And I login as an admin
    And a value proposition category and a color exist

  @javascript
  Scenario: Admin can edit an existing color
    When I visit the admin profile page
    When I go to manage colors
    When I go to edit an existing color
    When I change the name of the color
    When I save the edited color
    When I go to the general value proposition category index page
    Then I see the color has been edited
