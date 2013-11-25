Given(/^I navigate to the login page$/) do
  @login_page = LoginPage.new(page)
  @login_page.navigate
end

Given(/^I am on the homepage/) do
  @home_page = HomePage.new(page)
  @home_page.navigate
end