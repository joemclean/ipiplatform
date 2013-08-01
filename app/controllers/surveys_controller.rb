class SurveysController < ApplicationController
  def new
  end
  
  def take_survey
    @survey = Survey.new
    build_questions(20)
    @question_responses = QuestionResponse.all
  end

  def get_results
    @answer_hash = params['answers']

    @answer_ids = []
    @answer_hash.each do |question_number, trait_id|
      @answer_ids << trait_id.to_i
    end

    @trait_ids = []
    Trait.all.each do |trait|
      @trait_ids << trait.id
    end
    
    @score_hash = {}
    @trait_ids.each do |trait_id|
      answer_count = @answer_ids.count(trait_id)
      @score_hash[trait_id] = answer_count
    end

  end

  def build_questions(n)
    n.times do
      @survey.questions.build
    end
  end



end
