class PagesController < ApplicationController
  def home
  end

  def publisher
  end

  def innovator
    @traits = Trait.all
  end

end
