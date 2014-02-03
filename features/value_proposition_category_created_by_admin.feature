Feature: Creating new value proposition category as an admin

  Background:
    Given an admin account exists
    And I login as an admin

  Scenario: Admin can create a new value proposition category
    When I visit the admin profile page
    And I go to manage value proposition categories
    And I go to create a new value proposition category
    And I fill in all required value proposition category fields
    And I save the new value proposition category
    And I go to the general value proposition category index page
    Then I see the value proposition category I just created
