Feature: Creating steps as an admin

Background:
  Given an admin account exists
  And I login as an admin
  And a value proposition exists
  And I go to the edit value proposition page for the value proposition
  
Scenario: Step requires certain attributes
  When I click the link to the new step page
  And I submit the step
  Then I should see an error on all required step fields

Scenario: User creates a step with all fields and step is displayed on VP edit page
  When I click the link to the new step page
  And I fill in all step fields
  And I submit the step
  Then I should be redirected to the edit value proposition page for the value proposition
  And I should see the step
