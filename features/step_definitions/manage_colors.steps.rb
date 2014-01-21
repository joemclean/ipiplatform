When(/^I go to manage value proposition categories and colors together$/) do
  page.find('#manage_value_proposition_categories_and_colors').click
end

When(/^I create a new color$/) do
  page.find('#create_new_color').click
end

When(/^I fill in all required color fields$/) do
  step "I fill in \"color_name\" with \"New Color\""
  step "I fill in \"color_description\" with \"description\""
end

When(/^I save the new color$/) do
  page.find('#save').click
end

When(/^I go to the general value proposition category index page$/) do
  @general_value_proposition_category_page = GeneralValuePropositionCategoryPage.new(page)
  @general_value_proposition_category_page.navigate
end

Then(/^I see the color I just created$/) do
  page.should have_css('#color_id_1')
end

When(/^I go to edit an existing color$/) do
  find('#edit_color_1').click
end

When(/^I change the name of the color$/) do
  step "I fill in \"color_name\" with \"Changed Color\""
end

When(/^I save the edited color$/) do
  find('#save').click
end

When(/^I go to manage colors$/) do
  page.find('#manage_colors').click
end

Then(/^I see the color has been edited$/) do
  expect(find(:id, 'color_link_1').text).to eql('Changed Color')
end


And(/^I delete the color$/) do
  find('#delete_color_1').click
end

Then(/^I do not see the color$/) do
  expect(page.has_css?("#color_link_1")).to be_false
end