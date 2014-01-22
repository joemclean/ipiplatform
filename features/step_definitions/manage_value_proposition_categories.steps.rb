When(/^I visit the admin profile page$/) do
  page.find("#user_profile").click
end

And(/^I go to manage value proposition categories$/) do
  page.find('#manage_value_proposition_categories_and_colors').click
end

And(/^I create a new value proposition category$/) do
  page.find('#create_value_proposition_category').click
end

And(/^I fill in all required value proposition category fields$/) do
  step "I fill in \"value_proposition_category_name\" with \"New Value Proposition\""
  step "I fill in \"value_proposition_category_description\" with \"description\""
end

And(/^I save the new value proposition category$/) do
  find('#save_new_value_proposition_category').click
end

Then(/^I see the value proposition category I just created$/) do
  expect(page.has_css?("#value_proposition_category_1")).to be_true
end

And(/^I go to edit an existing value proposition category$/) do
  find('#edit_button_1').click
end

And(/^I change the name of the value proposition category$/) do
  step "I fill in \"value_proposition_category_name\" with \"Changed Value Proposition Category\""
end

And(/^I save the edited value proposition category$/) do
  page.execute_script('$("#save_button_1").click()')
end

Then(/^I see the value proposition category has been edited$/) do
  expect(find(:id, "value_proposition_category_#{@value_proposition_category.id}").text).to eql('Changed Value Proposition Category')
end

And(/^I delete the value proposition category$/) do
  find('#delete_button_1').click
end

Then(/^I do not see the value proposition category$/) do
  expect(page.has_css?("#value_proposition_category_1")).to be_false
end