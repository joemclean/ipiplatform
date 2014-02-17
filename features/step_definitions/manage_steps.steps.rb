When(/^I submit the step$/) do
  @new_step_page.save_button.click
end

When(/^I submit the step on the edit page$/) do
  @edit_step_page.save_button.click
end

Then(/^I should see an error on all required step fields$/) do
  @new_step_page.should have_name_field_error
end

When(/^I fill in all step fields$/) do
  @new_step_page.name.set("step_name")
  @new_step_page.description.set("description")
end

When(/^I select the step to edit$/) do
  @edit_step_page = EditStepPage.new
  @edit_value_proposition_page.edit_step_links[0].click
end

When(/^I edit the step name$/) do
  @edit_step_page.name.set("edited step name")
end

When(/^I select the step to delete/) do
  @edit_value_proposition_page.delete_step_links[0].click
end

Then(/^the step should no longer be displayed$/) do
  @edit_value_proposition_page.show_step_links.size.should eql 0
end