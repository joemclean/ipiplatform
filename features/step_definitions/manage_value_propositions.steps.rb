#When(/^I go to manage value proposition categories and colors together$/) do
#  page.find('#manage_value_proposition_categories_and_colors').click
#end

When(/^I create a new value proposition$/) do
  page.find('#create_new_value_proposition').click
end

When(/^I fill in all required value proposition fields$/) do
  step "I fill in \"value_proposition_name\" with \"New Value Proposition\""
  step "I fill in \"value_proposition_description\" with \"description\""
end

When(/^I save the new value proposition$/) do
  page.find('#save').click
end

When(/^I go to the general value proposition category index page$/) do
  @general_value_proposition_category_page = GeneralValuePropositionCategoryPage.new(page)
  @general_value_proposition_category_page.navigate
end
#
#When(/^I go to edit an existing value proposition$/) do
#  find('#edit_value_proposition_1').click
#end

When(/^I change the name of the value proposition$/) do
  step "I fill in \"value_proposition_name\" with \"Changed Value Proposition\""
end

When(/^I change the name of the first value proposition$/) do
  step "I fill in \"value_proposition_name_1\" with \"Changed Value Proposition\""
end

When(/^I save the edited value proposition$/) do
  find('#save').click
end

When(/^I go to manage all value propositions$/) do
  page.find('#manage_value_propositions').click
end

When(/^I save the first edited value proposition$/) do
  page.find('#save_button_1').click

end

Then(/^I see the value proposition I just created$/) do
  page.should have_css('#value_proposition_id_1')
end

Then(/^I see the value proposition has been edited$/) do
  expect(find(:id, 'value_proposition_link_1').text).to eql('Changed Value Proposition')
end

Then(/^I delete the value proposition$/) do
  find('#delete_value_proposition_1').click
end

Then(/^I do not see the value proposition$/) do
  expect(page.has_css?("#value_proposition_link_1")).to be_false
end