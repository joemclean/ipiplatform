class QuestionsController < ApplicationController
  before_filter :redirect_if_unauthorized
  
  def new
  end
end
