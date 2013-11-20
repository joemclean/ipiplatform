Feature: User Edits a Resource

  Background:
    Given a user account exists
    And a second user account exists
    And I login as a "user"
    And the user creates a resource
    And the second user creates a resource
    And I go to the resources index page


  @javascript
  Scenario: A user can edit his/her own resource from its resource show page
    When I go to my resource's show page
    And I try to edit my resource
    And I change the resource name
    And I submit the resource
    Then I see the resource's new name
    And I see a notification that the resource was updated
    And I am on the resources show page

  Scenario: A user can edit his/her own resource from the resource index page
    When I try to edit my resource
    And I change the resource name
    And I submit the resource
    Then I see the resource's new name
    And I see a notification that the resource was updated
    And I am on the resources show page

  Scenario: A user cannot edit other users' resources from the resource index page
    Then I do not have the option to edit another user's resource

  Scenario: A user cannot edit other users' resources from its resource show page
    When I go to a different user's resource's show page
    Then I do not have the option to edit another user's resource