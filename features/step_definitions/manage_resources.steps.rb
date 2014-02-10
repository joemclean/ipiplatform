
When(/^I try to edit my resource$/) do
  click_link_or_button("edit_resource_#{@resource.id}")
end

When(/^I change the resource name$/) do
  fill_in 'resource_name', :with => 'new_resource_title'
end

When(/^I go to delete the resource$/) do
  click_link_or_button("delete_resource_#{@resource.id}")
end

When(/^I go to delete the resource WHEN USING @BROWSER$/) do
  step 'I go to delete the resource'
  page.driver.browser.switch_to.alert.accept
end

When(/^I edit the second user's resource$/) do
  click_link_or_button("edit_resource_#{@resource2.id}")
end

When(/^I delete the second user's resource$/) do
  click_link_or_button("delete_resource_#{@resource2.id}")
end

When(/^I select the new resource$/) do
  click_link_or_button('resource_name_1')
end

When(/^I upload the image to the image upload$/) do
  page.attach_file('resource_image', File.join(Rails.root, '/app/assets/images/ResourcePlaceHolder.png'))
end

When(/^I select the image$/) do
  click_link_or_button('#resource_image_1')
end

When(/^I go to upload a file$/) do
  click_link_or_button('resource_file')
end

When(/^I upload the file to the file upload$/) do
  page.attach_file('resource_file', File.join(Rails.root, '/app/assets/images/ResourcePlaceHolder.png'))
end

Then(/^I should not have the option to edit another user's resource$/) do
  page.should_not have_selector("#edit_resource_#{@resource2.id}")
end

Then (/^I should see resources of (.*?) value propositions?$/) do |value_proposition_name|
  if value_proposition_name.include?('all')
    step 'I should see all resources'
  else
    step "I should see resources of the value proposition #{value_proposition_name}"
  end
end

Then (/^I should see resources of the value proposition (.*?)$/) do |value_proposition_name|
  value_proposition = ValueProposition.find_by_name(value_proposition_name)
  value_proposition.resources.each do |resource|
    @resource = resource
    expect(page.has_css?("#vp_#{value_proposition.id}_#{resource.id}")).to be_true
  end
end

Then(/^I should be on the new resources page$/) do
  expect(current_path).to eql('/resources/new')
end

Then(/^I should see the resource's new name$/) do
  expect(page.has_xpath?(one_resource_title_xpath)).to be_true
  expect(find(:id, "resource_#{@resource.id}_title").text).to eql('new_resource_title')
end

Then (/^I should see the second user's resource's new name$/) do
  expect(page.has_xpath?(second_resource_title_xpath)).to be_true
  expect(find(:id, "resource_#{@resource2.id}_title").text).to eql('new_resource_title')
end

Then(/^I should see a notification that the resource was updated$/) do
  expect(page.has_xpath?(notification_xpath)).to be_true
end

Then(/^I should be on the second user's resource show page$/) do
  expect(current_path).to eql("/resources/#{@resource2.id}")
end

Then(/^I should be on the new resources index page$/) do
  expect(current_path).to eql('/resources')
end

Then(/^the second user's resource should no longer be displayed$/) do
  expect(page.has_xpath?(second_resource_xpath)).to be_false
end

Then(/^I should not have the option to delete another user's resource$/) do
  page.should_not have_selector("#delete_resource_#{@resource2.id}")
end

Then(/^that resource should no longer be displayed$/) do
  expect(page.has_xpath?(one_resource_xpath)).to be_false
end

Then(/^I should be directed to the new resource's page$/) do
  expect(current_path).to eql('/resources/1')
end

Then(/^the uploaded image should be displayed$/) do
  find('.resource_image')['src'].should_not be_nil
end

Then(/^I should be able to download the file$/) do
  find('#resource_file_1')['href'].should_not be_nil
end
