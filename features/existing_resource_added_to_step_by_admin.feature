Feature: Adding existing resources to steps as an admin
  Background:
    Given an admin account exists
    And I login as an admin
    And a value proposition exists
    And a step exists for the value proposition
    And a resource exists
    And I am on the edit step page 

  @wip
  Scenario:
    When I navigate to the add existing resource page
    And I add the resource
    Then I should be redirected to the edit step page
    And I should see the resource
