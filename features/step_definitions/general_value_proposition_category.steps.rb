Then(/^I should see one value proposition category$/) do
  expect(page.has_xpath?(one_value_proposition_category_xpath)).to be_true
end

Then(/^I should see one value proposition$/) do
  expect(page.has_xpath?(one_value_proposition_xpath)).to be_true
end

Then(/^I should see the edited step name$/) do
  @edit_value_proposition_page.show_step_links.first.text.should == "edited step name"
end

Then(/^I should see the steps of the value proposition$/) do
  @show_value_proposition_page.steps.size.should eql 1
end

Then(/^I should see the resources of the value proposition$/) do
  @show_value_proposition_page.resources.size.should eql 2
end
private

  def one_value_proposition_category_xpath
    "//*[@id=\"value_proposition_category_name_#{@value_proposition_category.id}\"]"
  end

  def one_value_proposition_xpath
    "//*[@id=\"value_proposition_id_#{@value_proposition.id}\"]"
  end
