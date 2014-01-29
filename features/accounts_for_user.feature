Feature: Create account and log in as a user

  Background:
    Given a user account exists

  Scenario: User can create an account
    Given I am on the homepage
    And I am not logged in
    When I go to create an account
    And I fill in all required account fields
    Then I have access to my user profile

  Scenario: User can log in and log out
    Given I am not logged in
    When I login as a user
    Then I have access to my user profile
    When I go to log out
    Then I do not have access to my user profile

  Scenario: A user logging in from the homepage is returned there
    Given I am not logged in
    And I am on the homepage
    When I login as a user
    Then I should be on the home page

  Scenario: A user logging in from the value proposition category index page is returned there
    Given I am not logged in
    And I go to the general value proposition category index page
    When I login as an user
    Then I should be on the general value proposition category index page

  Scenario: User cannot view other users' accounts by changing the url
    Given I login as a user
    And a second user account exists
    When I change the url to user 2 profile page
    Then an error message is displayed
    And I am on the homepage
