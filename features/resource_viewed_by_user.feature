Feature: User Viewing Resources

  Background:
    Given a user account exists
    And I login as a "user"
    And a resource with a red value proposition exists

  Scenario: Users can see all resources
    When I go to the resources index page
    Then I see resources of all value propositions

  Scenario: Users can view a specific resource
    When I go to the resources index page
    And I go to my resource's show page
    Then I see details about the resource

  Scenario: Users can see resources associated with specific value proposition on value proposition show page
    When I go to red value proposition show page
    Then I see resources of red value proposition