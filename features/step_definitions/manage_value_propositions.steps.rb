When(/^I go to manage value propositions$/) do
  page.find('#manage_value_propositions').click
end

When(/^I create a new value proposition$/) do
  page.find('#create_new_color').click
end

When(/^I fill in all required value proposition fields$/) do
  step "I fill in \"color_name\" with \"New Value Proposition\""
  step "I fill in \"color_description\" with \"description\""
end

When(/^I save the new value proposition$/) do
  page.find('#save').click
end

When(/^I go to the general value proposition index page$/) do
  @general_value_proposition_page = GeneralValuePropositionPage.new(page)
  @general_value_proposition_page.navigate
end

Then(/^I see the value proposition I just created$/) do
  page.should have_css('#color_id_1')
end