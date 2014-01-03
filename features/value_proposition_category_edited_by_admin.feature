Feature: Editing an existing value proposition category as an admin

  Background:
    Given an admin account exists
    And I login as an admin
    And a value proposition exists

  @javascript
  Scenario:  Admin can edit an existing value proposition
    When I visit the admin profile page
    And I go to manage value proposition categories
    And I go to edit an existing value proposition category
    And I change the name of the value proposition category
    And I save the edited value proposition category
    And I go to the general value proposition category index page
    Then I see the value proposition category has been edited
