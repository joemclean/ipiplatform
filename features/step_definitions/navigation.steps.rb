Given(/^I navigate to the login page$/) do
  @login_page = LoginPage.new(page)
  @login_page.navigate
end