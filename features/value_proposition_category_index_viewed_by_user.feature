Feature: Value Proposition Category Index


  Background:
    Given a user account exists
    And I login as a "user"
    And a value proposition category and a value proposition exist

  Scenario: Users can see value proposition categories and value propositions on value proposition category index page
    When I go to the general value proposition category index page
    Then I see one value proposition category
    And I see one value proposition
