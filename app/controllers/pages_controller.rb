class PagesController < ApplicationController
  layout 'color_block', only: [:phases]
  
  def innovator
    @spectrums = Spectrum.all
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
