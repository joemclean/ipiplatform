Feature: User Deletes a Resource

  Background:
    Given a user account exists
    And I login as a "user"
    And a resource exists

  @javascript
  Scenario: A user can delete his/her own resource from the resource index page
    When I go to the resources index page
    And I go to delete the resource
    Then I am on the resources index page
    And that resource is no longer displayed