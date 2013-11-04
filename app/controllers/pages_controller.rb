class PagesController < ApplicationController
  
  def value_propositions
    @value_propositions = ValueProposition.all
  end

  def tools
    @resources = Resource.all
  end

  def phases
  end
  
  def aboutus
  end

  def landing
  end
  
end
