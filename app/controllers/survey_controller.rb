class SurveyController < ApplicationController
  def new
  end
  
  def create
    @survey = Survey.new
    5.times do
      @survey.questions.build
    end
  end

  def index
  end

end
