Feature: Admin views a value proposition

Background:
    Given an admin account exists
    And I login as an admin
    And a value proposition category and a value proposition exist
    And a step exists for the last value proposition
    And a resource exists for the last step
    And a resource exists for the last step

@javascript
Scenario: A user can view the steps and resources on the value proposition show page
    When I go to the last value proposition show page

    Then I should see the steps of the value proposition
    And I should see the resources of the value proposition

