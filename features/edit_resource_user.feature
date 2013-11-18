Feature: User Edits a Resource

  Background:
    Given a user account exists
    And I login as a "user"
    And a resource exists

  Scenario: A user can edit his/her own resource from the resource show page
    When I go to the resources index page
    And I go to one resource's show page
    And I go to edit the resource
    And I change the resource name
    And I submit the resource
    Then I see the resource's new name
    And I see a notification that the resource was updated
    And I am on the resources show page

  Scenario: A user can edit his/her own resource from the resource index page
    When I go to the resources index page
    And I go to edit the resource
    And I change the resource name
    And I submit the resource
    Then I see the resource's new name
    And I see a notification that the resource was updated
    And I am on the resources show page