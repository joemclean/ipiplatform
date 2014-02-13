Feature: Admin Deletes any Resource

Background:
  Given an admin account exists
  And I login as an admin
  And a step exists
  And the admin creates a resource
  And I am on the edit step page
  @javascript
Scenario: An admin can delete any resource from the resource index page
  When I select the resource to delete
  Then the resource should no longer be displayed
