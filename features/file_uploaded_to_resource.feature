
Feature: Uploading a file to a resource

Background:
Given a user account exists
Given I login as a user
Given I am on the resources index page
Given a value proposition category and a value proposition exist
Given I navigate to the resource creation page
Given I fill in required resource fields
@javascript
Scenario: User successfully uploads an file to a resource
When I upload the file to the file upload
When I submit the resource
When I select the new resource
Then I should be able to download the file
