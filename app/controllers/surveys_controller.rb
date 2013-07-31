class SurveysController < ApplicationController
  def new
  end
  
  def take_survey
    @survey = Survey.new
    5.times do
      @survey.questions.build
    end

    @question_responses = QuestionResponse.all
  end

  def results
    @answers = params['answers']

  end

end
