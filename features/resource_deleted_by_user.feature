Feature: User Deletes a Resource

  Background:
    Given a user account exists
    And a second user account exists
    And I login as a "user"
    And a step exists
    And the user creates a resource
    And the second user creates a resource
    And I go to the resources index page

  Scenario: A user can delete his/her own resource from the resource index page
    When I go to the resources index page
    And I go to delete the resource
    Then I should be on the resources index page
    And that resource should no longer be displayed

  Scenario: A user cannot delete other users' resources from the resource index page
    Then I should not have the option to delete another user's resource

  Scenario: A user cannot delete other users' resources from its resource show page
    When I go to a different user's resource's show page
    Then I should not have the option to delete another user's resource
