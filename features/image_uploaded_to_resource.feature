Feature: Uploading an image to a resource

   Background:
    Given a user account exists
    And I login as a user
    And I go to the resources index page
    And a value proposition category and a value proposition exist
    And I visit resource creation page
    And I fill in required resource fields

  @javascript
  Scenario: User successfully uploads an image to a resource
    When I go to upload an image
    When I upload the image to the image upload
    When I submit the resource
    And I go to the resources index page
    Then I select the image
    Then I go to the new resource's page

## Scenario: User uploads a disallowed file in the resource image field
#    When I go to upload a file
#    And select a file to upload
#    And I submit the resource
#    Then
