Feature: User Navigation

  Background:
    Given a user account exists
    And I login as a "user"
    And a resource exists

  Scenario: Users can see resources
    When I go to the resources index page
    Then I see one resource

  Scenario: Users can see a specific resource
    When I go to the resources index page
    And I go to one resource's show page
    Then I see details about the resource