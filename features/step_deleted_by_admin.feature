Feature: Admin Deletes any Step

  Background:
    Given an admin account exists
    And I login as an admin
    And a value proposition exists
    And a step exists for the value proposition
    And I go to the edit value proposition page for the value proposition
  @javascript
  Scenario: An admin can delete any step from the step index page
    When I select the step to delete
    Then the step should no longer be displayed
