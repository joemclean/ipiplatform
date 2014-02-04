Feature: Uploading an image to a resource

   Background:
    Given a user account exists
    Given I login as a user
    Given I am on the resources index page
    Given a value proposition category and a value proposition exist
    Given I navigate to the resource creation page
    Given I fill in required resource fields
  @wip
  @javascript
  Scenario: User successfully uploads an image to a resource
    When I upload the image to the image upload
    When I submit the resource
    When I go to the resources index page
    Then the uploaded image is displayed

