#Background:
#Given a user account exists
#Given I login as a user
#Given I am on the resources index page
#Given a value proposition category and a value proposition exist
#
#Scenario: User searches by value proposition and views related resources
#  When I input a search that matches a value proposition
#  And I submit the search
#  Then the only resources with that value proposition should be displayed
#
#Scenario: User searches by a value proposition that does not exist
#  When I input a search that does not match any value proposition
#  And I submit the search
#  Then no resources should be shown
#
#Scenario:
#
