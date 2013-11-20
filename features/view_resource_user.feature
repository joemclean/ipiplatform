Feature: User Viewing Resources

  Background:
    Given a user account exists
    And I login as a "user"
    And a resource with a red color exists

  Scenario: Users can see all resources
    When I go to the resources index page
    Then I see resources of all colors

  Scenario: Users can view a specific resource
    When I go to the resources index page
    And I go to my resource's show page
    Then I see details about the resource

  Scenario: Users can see resources associated with specific color on color show page
    When I go to red color show page
    Then I see resources of red color