When(/^I visit the admin profile page$/) do
  page.find("#user_profile").click
end

And(/^I go to manage value propositions$/) do
  page.find('#manage_value_propositions_and_colors').click
end

And(/^I create a new value proposition$/) do
  page.find('#create_value_proposition').click
end

And(/^I fill in all required value proposition fields$/) do
  step "I fill in \"value_proposition_name\" with \"New Value Proposition\""
  step "I fill in \"value_proposition_description\" with \"description\""
end

And(/^I save the new value proposition$/) do
  find("#save_new_value_proposition").click
end

Then(/^I see the value proposition I just created$/) do
  expect(page.has_css?("#value_proposition_1")).to be_true
end