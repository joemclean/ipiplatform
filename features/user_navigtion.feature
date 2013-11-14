Feature: User Navigation

  Background:
    Given a user account exists
    And I login as a "user"

  Scenario: Users can see resources
    Given a resource exists
    When I go to the resources index page
    Then I see one resource

  Scenario: Users can see a specific resource
    Given a resource exists
    When I go to the resources index page
    And I go to one resource's show page
    Then I see details about the resource

  Scenario: Users can see value propositions and colors on the general value proposition index page (pages/value_propositions/)
    Given a value proposition and a color exist
    When I go to the general value proposition index page
    Then I see one value proposition
    And I see one value proposition color
