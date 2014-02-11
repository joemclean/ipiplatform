Feature: Creating resources as a user

  Background:
    Given a user account exists
    And I login as a user
    And a step exists
    And I am on the add resource page for the last step

  Scenario: Resource requires certain attributes
    When I submit the resource
    Then I should see an error on all required fields

  Scenario: User creates a resource with all fields
    When I fill in all resource fields
    And I submit the resource
    And I navigate to the last resource show page
    Then I should see all the resource fields
