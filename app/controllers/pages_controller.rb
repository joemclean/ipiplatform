class PagesController < ApplicationController
  
  def value_proposition_categories
    @value_proposition_categories = ValuePropositionCategory.all
  end

  def aboutus
  end

  def landing
  end
  
end
