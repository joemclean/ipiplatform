Given(/^a user account exists$/) do
  @user = FactoryGirl.create(:user)
end

Given(/^an admin account exists$/) do
  @admin = FactoryGirl.create(:user, :admin)
end

Given(/^a second user account exists$/) do
  @user2 = FactoryGirl.create(:user)
end

Given(/^I login as an? (.*?)$/) do |user_type|
  step "I navigate to the login page"

  user = create_user_type(user_type)

  step "I fill in \"email\" with \"#{user.email}\""
  step "I fill in \"password\" with \"#{user.password}\""
  step 'I sign in'
end

Given(/^the user creates a resource$/) do
  @resource = FactoryGirl.create(:resource, user_id: @user.id)
end

Given(/^the second user creates a resource$/) do
  @resource2 = FactoryGirl.create(:resource, user_id: @user2.id)
end

Given(/^a value proposition exists$/) do
  @value_proposition = FactoryGirl.create(:value_proposition)
end

Given(/^a value proposition color exists$/) do
  @color = FactoryGirl.create(:color)
end

Given(/^a value proposition and a color exist$/) do
  @value_proposition = FactoryGirl.create(:value_proposition)
  @color = FactoryGirl.create(:color, value_proposition: @value_proposition)
end

Given(/^a phase exists$/) do
  @phase = FactoryGirl.create(:phase)
end

Given(/^a resource with a (.*?) color exists$/) do |color_name|
  @color = FactoryGirl.create(:color, name: color_name)
  @resource = FactoryGirl.create(:resource)
  @resource.colors << @color
end

private

def create_user_type(user_type)
  if user_type == "admin" && @admin.present?
    return @admin
  else
    return @user
  end
end