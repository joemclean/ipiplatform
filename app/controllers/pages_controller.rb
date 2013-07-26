class PagesController < ApplicationController
  layout 'color_block', only: [:phases]
  
  def home
  end

  def publisher
  end

  def innovator
    @traits = Trait.all
  end

  def tempphases
  end

  def SungTest
    @traits = Trait.all
  end
end
