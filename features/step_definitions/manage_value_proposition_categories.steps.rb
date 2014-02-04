When(/^I visit the admin profile page$/) do
  click_link_or_button 'user_profile'
end

When(/^I go to manage value proposition categories$/) do
  click_link_or_button 'manage_value_proposition_categories'
end

When(/^I go to create a new value proposition category$/) do
  click_link_or_button 'create_value_proposition_category'
end

When(/^I fill in all required value proposition category fields$/) do
  page.fill_in 'value_proposition_category_name', :with => 'New Value Proposition Category'
  page.fill_in 'value_proposition_category_description', :with => 'description'
end

When(/^I save the new value proposition category$/) do
  click_link_or_button 'save_new_value_proposition_category'
end

Then(/^I see the value proposition category I just created$/) do
  expect(page.has_css?("#value_proposition_category_name_1")).to be_true
end

And(/^I go to edit an existing value proposition category$/) do
  click_link_or_button 'edit_value_proposition_1'
end

And(/^I change the name of the value proposition category$/) do
  expect(has_css?("#value_proposition_category_name_#{@value_proposition_category.id}")).to be_true
  page.fill_in "value_proposition_category_name_#{@value_proposition_category.id}", :with => 'Changed Value Proposition Category'
end

And(/^I save the edited value proposition category$/) do
  page.execute_script("$('#save_button_1').click()")
end

Then(/^I see the value proposition category has been edited$/) do
  find('#value_proposition_category_name_1').should have_content("Changed Value Proposition Category")
end

And(/^I delete the value proposition category$/) do
  click_link_or_button 'delete_button_1'
end

Then(/^I do not see the value proposition category$/) do
  expect(page.has_css?("#value_proposition_category_1")).to be_false
end
