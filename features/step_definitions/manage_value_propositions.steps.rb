When(/^I create a new value proposition$/) do
  click_link_or_button 'create_new_value_proposition'
end

When(/^I fill in all required value proposition fields$/) do
  page.fill_in 'value_proposition_name', :with => 'New Value Proposition'
  page.fill_in 'value_proposition_description', :with => 'description'
end

When(/^I save the new value proposition$/) do
  click_link_or_button 'save'
end

When(/^I go to the general value proposition category index page$/) do
  @general_value_proposition_category_page = GeneralValuePropositionCategoryPage.new
  @general_value_proposition_category_page.load
end

When(/^I go to the edit value proposition page for the value proposition$/) do
  @edit_value_proposition_page = EditValuePropositionPage.new
  @edit_value_proposition_page.load(id: @value_proposition.id)
end

When(/^I click the link to the new step page$/) do
  @new_step_page = NewStepPage.new
  @edit_value_proposition_page.add_step_link.click
end

When(/^I change the name of the value proposition$/) do
  page.fill_in 'value_proposition_name', :with => 'Changed Value Proposition'
end

When(/^I change the name of the first value proposition$/) do
  page.fill_in 'value_proposition_name_1', :with => 'Changed Value Proposition'
end

When(/^I save the edited value proposition$/) do
  click_link_or_button 'save'
end

When(/^I go to manage all value propositions$/) do
  click_link_or_button 'manage_value_propositions'
end

When(/^I save the first edited value proposition$/) do
  page.execute_script("$('#save_button_1').click()")
end

Then(/^I should see the value proposition I just created$/) do
  @general_value_proposition_category_page.should have_value_proposition
end

Then(/^I should see the value proposition has been edited$/) do
  page.find('#value_proposition_link_1').should have_content('Changed Value Proposition')
end

Then(/^I delete the value proposition$/) do
  find('#delete_value_proposition_1').click
end

Then(/^I should not see the value proposition$/) do
  expect(page.has_css?("#value_proposition_link_1")).to be_false
end

Then(/^I should be redirected to the edit value proposition page for the value proposition$/) do
  @edit_value_proposition_page.should be_displayed
end

Then(/^I should see the step$/) do
  @edit_value_proposition_page.should have_show_step_links

end
