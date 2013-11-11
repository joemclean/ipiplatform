When(/^I go to the resources index page$/) do
  @resource_page = ResourcePage.new(page)
  @resource_page.navigate
end

When(/^I go to one resource's show page$/) do
  step 'I see one resource'

  @resource_page.navigate_to_show_page @resource.id
end

Then(/^I see one resource$/) do
  expect(page.has_xpath?(one_resource_xpath)).to be_true
end

Then(/^I see details about the resource$/) do
  expect(page.has_xpath?(one_resource_title_xpath)).to be_true
end


private

  def one_resource_xpath
    "//*[@id=\"resource_#{@resource.id}\"]"
    end

  def one_resource_title_xpath
    "//*[@id=\"resource_#{@resource.id}_title\"]"
  end