class QuestionsController < ApplicationController
  before_filter :authorized?
  
  def new
  end
end
