Feature: Editing new value proposition as an admin

  Background:
    Given an admin account exists
    And I login as an admin
    And a value proposition and a color exist

  @javascript
  Scenario: Admin can edit an existing value proposition
    When I visit the admin profile page
    When I go to manage colors
    When I go to edit an existing value proposition
    When I change the name of the value proposition
    When I save the edited value proposition
    When I go to the general value proposition index page
    Then I see the value proposition has been edited
