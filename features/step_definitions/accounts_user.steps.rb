When(/^I am not logged in$/) do
  page.should_not have_selector("#user_profile")
end

When(/^I go to create an account$/) do
  find("#create_account").click
end

When(/^I fill in all required account fields$/) do
  step "I fill in \"user_name\" with \"name\""
  step "I fill in \"user_email\" with \"email\""
  step "I fill in \"user_password\" with \"password\""
  step "I fill in \"user_password_confirmation\" with \"password\""
  find(".submitbutton").click
end

Then(/^I have access to my user profile$/) do
  expect(page.has_css?("#user_profile")).to be_true
end

When(/^I go to log out$/) do
  find("#log_out").click
end

Then(/^I do not have access to my user profile$/) do
  expect(page.has_css?("#user_profile")).to be_false
end

When(/^I change the url to user (.*?) profile page$/) do |user_id|
  @user_profile_page = UserProfilePage.new(page, user_id)
  @user_profile_page.navigate
end

Then(/^an error message is displayed$/) do
  pending
end

