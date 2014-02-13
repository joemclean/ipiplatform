When(/^I submit the step$/) do
  @new_step_page.save_button.click
end

Then(/^I should see an error on all required step fields$/) do
  @new_step_page.should have_name_field_error
end

When(/^I fill in all step fields$/) do
  @new_step_page.name.set("step_name")
  @new_step_page.description.set("description")
end
