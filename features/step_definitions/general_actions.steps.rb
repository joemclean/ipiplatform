Given(/^I sign in$/) do
  step "I click the \"login_submit\" button"
end

When (/^(?:|I )fill in "([^\"]*)" with "([^\"]*)"$/) do |field, value|
  fill_in(field, :with => value)
end

When(/^I click the "(.*?)" button$/) do |button_name|
  click_button(button_name)
end