Feature: Uploading a file to a resource

Background:
  Given a user account exists
  Given I login as a user
  Given a step exists
  Given I am on the add resource page for the last step 
  Given I fill in required resource fields

@javascript
Scenario: User successfully uploads an file to a resource
  When I upload the file to the file upload
  When I submit the resource
  When I navigate to the last resource show page
  Then I should be able to download the file
