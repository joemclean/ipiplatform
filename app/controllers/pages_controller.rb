class PagesController < ApplicationController
  layout 'color_block', only: [:phases]
  
  def home
  end

  def publisher
  end

  def innovator
    @spectrums = Spectrum.all
  end
  
  def tools
    @resources = Resource.all
  end

  def phases
  end

  def SungTest
    @traits = Trait.all
  end
  
  def aboutus
  end

  def landing
  end
  
end
