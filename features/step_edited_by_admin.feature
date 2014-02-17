Feature: Editing steps as an admin

Background:
  Given an admin account exists
  And I login as an admin
  And a value proposition exists
  And a step exists for the value proposition
  And I go to the edit value proposition page for the value proposition
  
Scenario: User edits step
  When I select the step to edit
  And I edit the step name
  And I submit the step on the edit page
  Then I should be redirected to the edit value proposition page for the value proposition
  And I should see the edited step name
