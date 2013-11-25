Feature: Create account and log in as a user

  Background:
    Given a user account exists
    And a second user account exists

  Scenario: User can create an account
    Given I am on the homepage
    And I am not logged in
    When I go to create an account
    And I fill in all required account fields
    Then I have access to my user profile

  Scenario: User can log in
    Given I am not logged in
    When I login as a user
    Then I have access to my user profile

  Scenario: User can log out
    And I login as a user
    When I go to log out
    Then I do not have access to my user profile

  Scenario: User cannot view other users' accounts by changing url
    Given I login as a user
    When I change the url to user 2 profile page
    Then an error message is displayed
