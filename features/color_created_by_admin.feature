Feature: Creating a new color as an admin

  Background:
    Given an admin account exists
    And I login as an admin
    And a value proposition category exists

 @javascript
  Scenario: Admin can create a new color
    When I visit the admin profile page
    When I go to manage colors
    When I create a new color
    When I fill in all required color fields
    When I save the new color
    When I go to the general value proposition category index page
    Then I see the color I just created
