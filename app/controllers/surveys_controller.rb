class SurveysController < ApplicationController
  
  def take_survey
    @survey = Survey.new
    @survey.generate_questions
    @question_responses = QuestionResponse.all
  end

  def get_results
    survey = Survey.new
    @answer_hash = params['answers']
    survey.answers = @answer_hash
    @score_hash = survey.score
    #@score_hash.sort_by{|trait_id, count| count}
    @score_hash = @score_hash.sort_by{|trait_id, count| count}.reverse
    @score_hash = @score_hash.first(4)

  end
end
