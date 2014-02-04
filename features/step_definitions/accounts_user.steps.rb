Given(/^I login as an? (.*?)$/) do |user_type|
  @login_page = LoginPage.new(page)
  @login_page.navigate
  user = create_user_type(user_type)
  fill_in 'email', :with => user.email
  fill_in 'password', :with => user.password
  click_link_or_button 'login_submit'
end

When(/^I go to create an account$/) do
  click_link_or_button 'create_account'
end

When(/^I fill in all required account fields$/) do
  fill_in 'user_name', :with => 'name'
  fill_in 'user_email', :with => 'email'
  fill_in 'user_password', :with => 'password'
  fill_in 'user_password_confirmation', :with => 'password'
  click_link_or_button 'new_user_submit'
end

When(/^I go to log out$/) do
  click_link_or_button 'log_out'
end

Then(/^I should have access to my user profile$/) do
  assert page.has_css?("#user_profile")
end

Then(/^I should not have access to my user profile$/) do
  expect(page.has_css?("#user_profile")).to be_false
end

Then(/^an? (.*?) error message is displayed$/) do |error_type|
  assert page.has_css?("div.flash")
  find('div.flash').should have_content('You are not authorized to view that page.') if error_type == 'authorization'
  find('div.flash').should have_content('Invalid username or password.') if error_type == 'login'
end

Then(/^I should be on the homepage$/) do
  expect(current_path).to eql('/')
end

Then(/^I should be on the general value proposition category index page$/) do
  expect(current_path).to eql('/pages/value_proposition_categories')
end