class SurveysController < ApplicationController
  def new
  end
  
  def take_survey
    @survey = Survey.new
    build_questions(25)
    @question_responses = QuestionResponse.all
  end

  def get_results
    survey = Survey.new
    @answer_hash = params['answers']
    survey.answers = @answer_hash
    @score_hash = survey.score
  end

  def build_questions(n)
    n.times do
      @survey.questions.build
    end
  end
end
