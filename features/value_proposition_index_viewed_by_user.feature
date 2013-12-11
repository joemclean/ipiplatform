Feature: Value Proposition Index

  Background:
    Given a user account exists
    And I login as a "user"
    And a value proposition and a color exist

  Scenario: Users can see value propositions and colors on value proposition index page
    When I go to the general value proposition index page
    Then I see one value proposition
    And I see one value proposition color
