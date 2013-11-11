Given(/^a user account exists$/) do
  @user = FactoryGirl.create(:user)
end

Given(/^I login as a "(.*?)"$/) do |user_type|
  step "I navigate to the login page"
  step "I fill in \"email\" with \"#{@user.email}\""
  step "I fill in \"password\" with \"#{@user.password}\""
  step 'I sign in'
end

Given(/^a resource exists$/) do
  @resource = FactoryGirl.create(:resource)
end
