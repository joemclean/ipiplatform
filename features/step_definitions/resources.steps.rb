
When(/^I go to my resource's show page$/) do
  click_link_or_button 'resource_name_1'
end

When(/^I go to a different user's resource's show page$/) do
  click_link_or_button 'resource_name_2'
end

When(/^I navigate to the resource creation page$/) do
  click_link_or_button 'new_resource'
end

When(/^I fill in required resource fields$/) do
  page.fill_in 'resource_name', :with => 'name'
  page.fill_in 'resource_link', :with => 'link'
  page.fill_in 'resource_description', :with => 'desc'
  page.fill_in 'resource_full_description', :with => 'full desc'
  page.fill_in 'resource_source', :with => 'source'
end

When(/^I fill in all resource fields$/) do
  step 'I fill in required resource fields'
  page.fill_in 'resource_tag_list', :with => 'tag'
  check 'value_proposition_id_1'
end

When(/^I submit the resource$/) do
  click_link_or_button('submit_resource')
end

When(/^I try to edit my resource$/) do
  find("#edit_resource_#{@resource.id}").click
end

Then(/^I do not have the option to edit another user's resource$/) do
  page.should_not have_selector("#edit_resource_#{@resource2.id}")
end

When(/^I change the resource name$/) do
  fill_in 'resource_name', :with => 'new_resource_title'

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

When(/^I delete the second user's resource$/) do
  page.find("#delete_resource_#{@resource2.id}").click
end

When(/^I upload the image to the image upload$/) do
  page.attach_file('resource_image', File.join(Rails.root, '/app/assets/images/ResourcePlaceHolder.png'))
  #page.attach_file(resource_image, '/app/assets/images/ResourcePlaceHolder.png')
end

Then(/^I see an error on all required fields$/) do
  expect(page.find('.field_with_errors #resource_name')).to be_true
  expect(page.find('.field_with_errors #resource_link')).to be_true
  expect(page.find('.field_with_errors #resource_description')).to be_true
  expect(page.find('.field_with_errors #resource_full_description')).to be_true
  expect(page.find('.field_with_errors #resource_source')).to be_true
end

Then(/^the second user's edit resource button is visible$/) do
  page.should have_selector("#edit_resource_#{@resource2.id}")
end

Then(/^I see one resource$/) do
  @resource = Resource.first if @resource.nil?
  expect(page.has_xpath?(one_resource_xpath)).to be_true
end

Then (/^I see resources of (.*?) value propositions?$/) do |value_proposition_name|
  if value_proposition_name.include?('all')
    step 'I see all resources'
  else
    step "I see resources of the value proposition #{value_proposition_name}"
  end
end

Then (/^I see all resources$/) do
  Resource.all.each do |resource|
    @resource = resource
    expect(page.has_xpath?(one_resource_xpath)).to be_true
  end
end

Then (/^I see resources of the value proposition (.*?)$/) do |value_proposition_name|
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
  expect(find(:id, "resource_#{@resource.id}_title").text).to eql('new_resource_title')
end

Then (/^I see the second user's resource's new name$/) do
  expect(page.has_xpath?(second_resource_title_xpath)).to be_true
  expect(find(:id, "resource_#{@resource2.id}_title").text).to eql('new_resource_title')
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

Then(/^the second user's resource should no longer be displayed$/) do
  expect(page.has_xpath?(second_resource_xpath)).to be_false
end

Then(/^I should not have the option to delete another user's resource$/) do
  page.should_not have_selector("#delete_resource_#{@resource2.id}")
end

Then(/^the second user's delete resource button is visible$/) do
  page.should have_selector("#delete_resource_#{@resource2.id}")
end

Then(/^that resource should no longer be displayed$/) do
  expect(page.has_xpath?(one_resource_xpath)).to be_false
end

When(/^I select the image$/) do
  find('#resource_image_1').click
end

Then(/^I should be directed to the new resource's page$/) do
  expect(current_path).to eql('/resources/1')
end

private

def one_resource_xpath
  "//*[@id=\"resource_#{@resource.id}\"]"
  end

def second_resource_xpath
  "//*[@id=\"resource_#{@resource2.id}\"]"
end

def second_resource_title_xpath
  "//*[@id=\"resource_#{@resource2.id}_title\"]"
end

def one_resource_title_xpath
  "//*[@id=\"resource_#{@resource.id}_title\"]"
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
  find('#resource_file').click
end

When(/^I upload the file to the file upload$/) do
 page.attach_file('resource_file', File.join(Rails.root, '/app/assets/images/ResourcePlaceHolder.png'))
  #page.attach_file(resource_image, '/app/assets/images/ResourcePlaceHolder.png')
end

Then(/^I select the file$/) do
  find('#resource_file_1').click
end

Then(/^I should be on the resources index page$/) do
  expect(current_path).to eql('/resources')
end

When(/^I select the new resource$/) do
  find('#resource_name_1').click
end

Then(/^the uploaded image is displayed$/) do
  find('#resource_image_1')['src'].should_not be_nil
end

Then(/^I should be able to download the file$/) do
  find('#resource_file_1')['href'].should_not be_nil

end

Then(/^I go to the resources index page$/) do
  find('#resources_index').click
end