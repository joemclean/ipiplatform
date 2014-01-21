Then(/^I see one value proposition category$/) do
  expect(page.has_xpath?(one_value_proposition_category_xpath)).to be_true
end

Then(/^I see one color$/) do
  expect(page.has_xpath?(one_color_xpath)).to be_true
end

private

  def one_value_proposition_category_xpath
    "//*[@id=\"value_proposition_category_#{@value_proposition_category.id}\"]"
  end

  def one_color_xpath
    "//*[@id=\"color_id_#{@color.id}\"]"
  end
