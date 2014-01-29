When(/^I go to the resources index page$/) do
  @resource_page = ResourcePage.new(page)
  @resource_page.navigate
end

When (/^I go to (.*?) value proposition show page$/) do |value_proposition|
  @value_proposition_show_page = ValuePropositionPage.new(page)
  @value_proposition_show_page.navigate_to_show_page @value_proposition.id
end

When(/^I go to my resource's show page$/) do
  @resource_page.navigate_to_show_page @resource.id
end

When(/^I go to a different user's resource's show page$/) do
  @resource_page.navigate_to_show_page @resource2.id
end

When(/^I visit resource creation page$/) do
  page.find('#new_resource').click
end

When(/^I fill in required resource fields$/) do
  step "I fill in \"resource_name\" with \"name\""
  step "I fill in \"resource_link\" with \"link\""
  step "I fill in \"resource_description\" with \"desc\""
  step "I fill in \"resource_full_description\" with \"full desc\""
  step "I fill in \"resource_source\" with \"source\""
end

When(/^I fill in all resource fields$/) do
  step 'I fill in required resource fields'
  step "I fill in \"resource_tag_list\" with \"tag\""
  step "I check the value_proposition_id_#{@value_proposition.id} box"
end

When(/^I submit the resource$/) do
  page.find('#submit_resource').click
end

Then(/^I see an error on all required fields$/) do
  expect(page.find('.field_with_errors #resource_name')).to be_true
  expect(page.find('.field_with_errors #resource_link')).to be_true
  expect(page.find('.field_with_errors #resource_description')).to be_true
  expect(page.find('.field_with_errors #resource_full_description')).to be_true
  expect(page.find('.field_with_errors #resource_source')).to be_true
end

When(/^I try to edit my resource$/) do
  page.find("#edit_resource_#{@resource.id}").click
end

Then(/^I do not have the option to edit another user's resource$/) do
  page.should_not have_selector("#edit_resource_#{@resource2.id}")
end

When(/^I change the resource name$/) do
  step "I fill in \"resource_name\" with \"#{new_resource_title}\""
end

When(/^I go to delete the resource$/) do
  page.find("#delete_resource_#{@resource.id}").click
end

When(/^I go to delete the resource WHEN USING @BROWSER$/) do
  step 'I go to delete the resource'

  page.driver.browser.switch_to.alert.accept
end

When(/^I edit the second user's resource$/) do
  page.find("#edit_resource_#{@resource2.id}").click
end

Then(/^the second user's edit resource button is visible$/) do
  page.should have_selector("#edit_resource_#{@resource2.id}")
end

When(/^I delete the second user's resource$/) do
  page.find("#delete_resource_#{@resource2.id}").click
end

When(/^I go to upload an image$/) do
  #page.find('#resource_image').click
end

When(/^I upload the image to the image upload$/) do
  page.attach_file('resource_image', File.join(Rails.root, '/app/assets/images/ResourcePlaceHolder.png'))
end

Then(/^I see one resource$/) do
  @resource = Resource.first if @resource.nil?
  expect(page.has_xpath?(one_resource_xpath)).to be_true
end

Then (/^I see resources of (.*?) value propositions?$/) do |value_proposition_name|
  if value_proposition_name.include?('all')
    step 'I see all resources'
  else
    step "I see resources of the value proposition \"#{value_proposition_name}\""
  end
end

Then (/^I see all resources$/) do
  Resource.all.each do |resource|
    @resource = resource
    expect(page.has_xpath?(one_resource_xpath)).to be_true
  end
end

Then (/^I see resources of the value proposition "(.*?)"$/) do |value_proposition_name|
  value_proposition = ValueProposition.find_by_name(value_proposition_name)
  value_proposition.resources.each do |resource|
    @resource = resource
    expect(page.has_css?("#vp_#{value_proposition.id}_#{resource.id}")).to be_true
  end
end

Then(/^I see details about the resource$/) do
  expect(page.has_xpath?(one_resource_title_xpath)).to be_true
end

Then(/^I should be on the new resources page$/) do
  expect(current_path).to eql('/resources/new')
end

Then(/^I see the resource's new name$/) do
  expect(page.has_xpath?(one_resource_title_xpath)).to be_true
  expect(find(:id, "resource_#{@resource.id}_title").text).to eql(new_resource_title)
end

Then (/^I see the second user's resource's new name$/) do
  expect(page.has_xpath?(second_resource_title_xpath)).to be_true
  expect(find(:id, "resource_#{@resource2.id}_title").text).to eql(new_resource_title)
end

Then(/^I see a notification that the resource was updated$/) do
  expect(page.has_xpath?(notification_xpath)).to be_true
end

Then(/^I am on the resources show page$/) do
  expect(current_path).to eql("/resources/#{@resource.id}")
end

Then(/^I am on the second user's resource show page$/) do
  expect(current_path).to eql("/resources/#{@resource2.id}")
end

Then(/^I am on the new resources index page$/) do
  expect(current_path).to eql('/resources')
end

Then(/^the second user's resource is no longer displayed$/) do
  expect(page.has_xpath?(second_resource_xpath)).to be_false
end

Then(/^I do not have the option to delete another user's resource$/) do
  page.should_not have_selector("#delete_resource_#{@resource2.id}")
end

Then(/^the second user's delete resource button is visible$/) do
  page.should have_selector("#delete_resource_#{@resource2.id}")
end

Then(/^that resource is no longer displayed$/) do
  expect(page.has_xpath?(one_resource_xpath)).to be_false
end

Then(/^I select the image$/) do
  page.find('#resource_image_1').click
end

Then(/^I go to the new resource's page$/) do
  expect(current_path).to eql('/resources/1')
end

private

def one_resource_xpath
  "//*[@id=\"resource_#{@resource.id}\"]"
  end

def second_resource_xpath
  "//*[@id=\"resource_#{@resource2.id}\"]"
end

def one_resource_title_xpath
  "//*[@id=\"resource_#{@resource.id}_title\"]"
end

def second_resource_title_xpath
  "//*[@id=\"resource_#{@resource2.id}_title\"]"
end

def one_resource_title_xpath
  "//*[@id=\"resource_#{@resource.id}_title\"]"
end

def new_resource_title
  'Greatest Resource'
end

def notification_xpath
  "//*[@class=\"flash\"]"
end

def current_path
  URI.parse(current_url).path
end

When(/^I use the garbage step$/) do
  binding.pry
end


When(/^I go to upload a file$/) do
page.find('#resource_file').click
end

When(/^I upload the file to the file upload$/) do
 page.attach_file('resource_file', File.join(Rails.root, '/app/assets/images/ResourcePlaceHolder.png'))
end


Then(/^I select the file$/) do
expect(page.find("resource_file_#{Resource.first.id}")).click
end

Then(/^I am on the resources index page$/) do
  expect(current_path).to eql('/resources')
end