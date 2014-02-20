Given(/^a user account exists$/) do
  @user = FactoryGirl.create(:user)
end

Given(/^an admin account exists$/) do
  @admin = FactoryGirl.create(:user, :admin)
end

Given(/^a second user account exists$/) do
  @user2 = FactoryGirl.create(:user)
end

Given(/^the user creates a resource$/) do
  @step = @step || FactoryGirl.create(:step)
  @resource = FactoryGirl.create(:resource, user_id: @user.id, step_id: @step.id)
end

Given(/^the admin creates a resource$/) do
  @step = @step || FactoryGirl.Create(:step)
  @resource = FactoryGirl.create(:resource, user_id: @admin.id, step_id: @step.id)
end
Given(/^the second user creates a resource$/) do
  @step = @step || FactoryGirl.create(:step)
  @resource2 = FactoryGirl.create(:resource, user_id: @user2.id, step_id: @step.id)
end

Given(/^a value proposition category exists$/) do
  @value_proposition_category = FactoryGirl.create(:value_proposition_category)
end

Given(/^a value proposition exists$/) do
  @value_proposition = FactoryGirl.create(:value_proposition)
end

Given(/^a step exists$/) do
  @step = FactoryGirl.create(:step)
end

Given(/^a step exists for the value proposition$/) do
  @step = FactoryGirl.create(:step, value_proposition_id: @value_proposition.id)
end

Given(/^a value proposition category and a value proposition exist$/) do
  @value_proposition_category = FactoryGirl.create(:value_proposition_category)
  @value_proposition = FactoryGirl.create(:value_proposition, value_proposition_category: @value_proposition_category)
end

Given(/^a resource exists$/) do
  @resource = FactoryGirl.create(:resource)
end

Given(/^a resource with a (.*?) value proposition exists$/) do |value_proposition_name|
  @value_proposition = FactoryGirl.create(:value_proposition, name: value_proposition_name)
  @resource = FactoryGirl.create(:resource)
  @resource.value_propositions << @value_proposition
end

Given(/^a step exists for the last value proposition$/) do
  @step = FactoryGirl.create(:step, value_proposition: ValueProposition.last )
end

Given(/^a resource exists for the last step$/) do
  @resoure = FactoryGirl.create(:resource, step: Step.last)
end
private

def create_user_type(user_type)
  if user_type == "admin" && @admin.present?
    return @admin
  else
    return @user
  end
end
