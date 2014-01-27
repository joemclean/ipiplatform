Feature: Creating resources as a user

  Background:
    Given a user account exists
    And I login as a user
    And I go to the resources index page
    And a value proposition exists

  Scenario: User can create a resource
    When I visit resource creation page
    Then I should be on the new resources page
    And I fill in required resource fields
    And I submit the resource
    And I go to the resources index page
    Then I see one resource

  Scenario: Resource requires certain attributes
    When I visit resource creation page
    And I submit the resource
    Then I see an error on all required fields

  Scenario: User creates a resource with all fields
    When I visit resource creation page
    And I fill in all resource fields
    And I submit the resource
    And I go to the resources index page
    Then I see one resource


