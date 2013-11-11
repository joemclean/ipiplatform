When(/^I go to the general value proposition index page$/) do
  @general_value_proposition_page = GeneralValuePropositionPage.new(page)
  @general_value_proposition_page.navigate
end

Then(/^I see one value proposition$/) do
  expect(page.has_xpath?(one_value_proposition_xpath)).to be_true
end

Then(/^I see one value proposition color$/) do
  expect(page.has_xpath?(one_color_xpath)).to be_true
end


private

  def one_value_proposition_xpath
    "//*[@id=\"value_proposition_#{@value_proposition.id}\"]"
  end

  def one_color_xpath
    "//*[@id=\"value_proposition_#{@color.id}\"]"
  end
