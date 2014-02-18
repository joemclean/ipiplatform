
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
end

When(/^I submit the resource$/) do
  click_link_or_button('submit_resource')
end

When(/^I go to the resources index page$/) do
  click_link_or_button 'resources_index'
end

Then(/^I should see all the resource fields with step$/) do
  page.should have_content 'name'
  page.should have_content 'link'
  page.should have_content 'desc'
  page.should have_content 'full desc'
  page.should have_content 'source'
  page.should have_content 'tag'
  page.should have_content Step.last.name
  end

Then(/^I should see all the resource fields without step$/) do
  page.should have_content 'name'
  page.should have_content 'link'
  page.should have_content 'desc'
  page.should have_content 'full desc'
  page.should have_content 'source'
  page.should have_content 'tag'
end

Then(/^I should see an error on all required fields$/) do
  expect(page.find('.field_with_errors #resource_name')).to be_true
  expect(page.find('.field_with_errors #resource_link')).to be_true
  expect(page.find('.field_with_errors #resource_description')).to be_true
  expect(page.find('.field_with_errors #resource_full_description')).to be_true
  expect(page.find('.field_with_errors #resource_source')).to be_true
end

Then(/^I should see one resource$/) do
  @resource = Resource.first if @resource.nil?
  expect(page.has_xpath?(one_resource_xpath)).to be_true
end


Then (/^I should see all resources$/) do
  Resource.all.each do |resource|
    @resource = resource
    expect(page.has_xpath?(one_resource_xpath)).to be_true
  end
end

Then(/^I should see details about the resource$/) do
  expect(page.has_xpath?(one_resource_title_xpath)).to be_true
end

Then(/^I should be on the resources show page$/) do
  expect(current_path).to eql("/resources/#{@resource.id}")
end

Then(/^I should be on the resources index page$/) do
  expect(current_path).to eql('/resources')
end

When(/^I select the resource to edit$/) do
  @edit_step_page.resources_to_edit[0].click
end

When(/^I select the resource to delete/) do
  @edit_step_page.resources_to_delete[0].click
end

When(/I click the new resource button$/) do
  @resources_page.new_resource_button.click

end

When(/^I edit the resource name$/) do
  @edit_step_page.resource_name.set "Edited resource name"
end

Then(/^I should see the edited resource name$/) do
  @edit_step_page.resource_names[0].text.should eql "Edited resource name"
end

Then(/^the resource should no longer be displayed$/) do
  @edit_step_page.step_resource.size.should eql 0
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

