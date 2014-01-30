Given(/^I am on the login page$/) do
  @login_page = LoginPage.new(page)
  @login_page.navigate
end

Given(/^I am on the homepage/) do
  @home_page = HomePage.new(page)
  @home_page.navigate
end

Given(/^I am on the user (.*?) profile page$/) do |user_id|
  @user_profile_page = UsersPage.new(page, user_id)
  @user_profile_page.navigate
end

When(/^I change the url to user (.*?) profile page$/) do |user_id|
  step "I am on the user #{user_id} profile page"
end