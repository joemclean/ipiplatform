class PagesController < ApplicationController
  def home
  end

  def publisher
  end

  def innovator
    @traits = Trait.all
  end

  def Phases
  end

  def SungTest
    @traits = Trait.all
  end
end
