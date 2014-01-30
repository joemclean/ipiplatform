When(/^I go to create an account$/) do
  find("#create_account").click
end

When(/^I fill in all required account fields$/) do
  step 'I fill in user_name with name'
  step 'I fill in user_email with email'
  step 'I fill in user_password with password'
  step 'I fill in user_password_confirmation with password'
  find(".submitbutton").click
end

Then(/^I should have access to my user profile$/) do
  assert page.has_css?("#user_profile")
end

When(/^I go to log out$/) do
  find("#log_out").click
end

Then(/^I should not have access to my user profile$/) do
  expect(page.has_css?("#user_profile")).to be_false
end

Then(/^an? (.*?) error message is displayed$/) do |error_type|
  assert page.has_css?("div.flash")
  find('div.flash').should have_content('You are not authorized to view that page.') if error_type == 'authorization'
  find('div.flash').should have_content('Invalid username or password.') if error_type == 'login'
end

Then(/^I am on my user profile page/) do
  expect(current_path).to eql("/users/#{@user.id}")
end

Then(/^I should be on the homepage$/) do
  expect(current_path).to eql('/')
end

Then(/^I should be on the general value proposition category index page$/) do
  expect(current_path).to eql('/pages/value_proposition_categories')
end