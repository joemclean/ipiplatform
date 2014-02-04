Feature: Admin Edits any Resource

  Background:
    Given an admin account exists
    And a second user account exists
    And the second user creates a resource
    And I login as an admin

  @javascript
  Scenario: An admin can edit any resource from the resource index page
    When I go to the resources index page
    When I edit the second user's resource
    And I change the resource name
    And I submit the resource
    Then I should see the second user's resource's new name
    And I should see a notification that the resource was updated
    And I should be on the second user's resource show page

