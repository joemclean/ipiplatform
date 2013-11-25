When(/^I am not logged in$/) do
  page.should_not have_selector("#user_profile")
end

When(/^I go to create an account$/) do
  find_by_id("create_account").click
end
When(/^I fill in all required account fields$/) do
  step "I fill in \"user_name\" with \"name\""
  step "I fill in \"user_email\" with \"email\""
  step "I fill in \"user_password\" with \"password\""
  step "I fill in \"user_password_confirmation\" with \"password\""
  find(".submitbutton").click
end
Then(/^I see a notification that my account was created$/) do
  expect(page.has_css?("#user_profile")).to be_true
end