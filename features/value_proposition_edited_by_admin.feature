Feature: Editing new value proposition as an admin

  Background:
    Given an admin account exists
    And I login as an admin
    And a value proposition category and a value proposition exist
  @javascript
  Scenario: Admin can edit an existing value proposition
    When I visit the admin profile page
    When I go to manage value proposition categories
    When I go to edit an existing value proposition category
    When I change the name of the first value proposition
    When I save the first edited value proposition
    When I go to the general value proposition category index page
    Then I should see the value proposition has been edited
