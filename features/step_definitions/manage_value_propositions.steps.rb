When(/^I go to manage value propositions and colors together$/) do
  page.find('#manage_value_propositions_and_colors').click
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

When(/^I go to edit an existing value proposition$/) do
  find('#edit_color_1').click
end

When(/^I change the name of the value proposition$/) do
  step "I fill in \"color_name\" with \"Changed Value Proposition\""
end

When(/^I save the edited value proposition$/) do
  find('#save').click
end

When(/^I go to manage colors$/) do
  page.find('#manage_value_propositions').click
end

Then(/^I see the value proposition has been edited$/) do
  expect(find(:id, 'color_link_1').text).to eql('Changed Value Proposition')
end


And(/^I delete the value proposition$/) do
  find('#delete_color_1').click
end

Then(/^I do not see the value proposition$/) do
  expect(page.has_css?("#color_link_1")).to be_false
end