#Feature: Uploading a file to a resource
#
#  Background:
#    Given a user account exists
#    And I login as a user
#    And I go to the resources index page
#    And a value proposition and a color exist
#    And I visit resource creation page
#    And I fill in required resource fields
#
#  @javascript
#  Scenario: User successfully uploads a file to a new resource
#    When I go to upload a file
#    When I upload the file to the file upload
#    When I submit the resource
#    And I go to the resources index page
#    Then I select the file
#    Then I go to the new resource's page

# Scenario: User uploads a disallowed file in the resource image field
#    When I go to upload a file
#    And select a file to upload
#    And I submit the resource
#    Then
