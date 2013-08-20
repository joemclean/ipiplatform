class SurveysController < ApplicationController
  

  def take_survey
    @survey = Survey.new
    @survey.generate_questions
    @question_responses = QuestionResponse.all
  end

  def get_results
    @survey = Survey.new
    evaluate_responses

    if current_user
      personality = current_user.build_personality

      @sorted_hash.each do |trait_id, trait_count|
        personality.traits << Trait.find(trait_id)
      end

      current_user.save
      @personality = personality
      redirect_to view_results_path
    else
      personality = Personality.new
      @sorted_hash.each do |trait_id, trait_count|
        personality.traits << Trait.find(trait_id)
      end
      personality.save
      session[:user_personality] = personality.id
      redirect_to new_session_path, notice:'Sign In/Sign up to view and save your survey!'
    end
  end

  def view_results
    if current_user && current_user.personality
      view_past_results
    else
      prompt_survey
    end
  end


  def evaluate_responses
    @survey.answers = params['answers']
    @sorted_hash = sort_results(@survey.score)
  end

  def view_past_results
    @personality = current_user.personality
  end

  def prompt_survey
    redirect_to take_survey_path, notice:'Please take the survey to see your innovator-type!'
  end

  def sort_results(survey_score)
    survey_score.sort_by{|trait_id, count| count}.reverse.first(5)
  end
end
