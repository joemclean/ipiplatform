class SurveysController < ApplicationController
  def new
  end
  
  def create
    @survey = Survey.new
    5.times do
      @survey.questions.build
    end

    @question_responses = QuestionResponse.all
  end

  def index
  end

end
