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

When(/^I am on the resources index page$/) do
  @resource_page = ResourcePage.new(page)
  @resource_page.navigate
end

Given(/^I am on the add resource page for the last step$/) do
  @new_resource_page = NewResourcePage.new(page, Step.last.id)
  @new_resource_page.navigate
end


When (/^I go to (.*?) value proposition show page$/) do |value_proposition|
  @value_proposition_show_page = ValuePropositionPage.new(page)
  @value_proposition_show_page.navigate_to_show_page @value_proposition.id
end

When(/^I use the garbage step$/) do
  binding.pry
end

When(/^I navigate to the last resource show page$/) do
  @resource_show_page = ResourcePage.new(page)
  @resource_show_page.navigate_to_show_page Resource.last.id
end
