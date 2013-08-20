class SurveysController < ApplicationController
  

  def take_survey
    @survey = Survey.new
    @survey.generate_questions
    @question_responses = QuestionResponse.all
  end

  def get_results
    survey = Survey.new(answers: params['answers'])
    sorted_results = sort_results(survey.score)
    top_traits = get_top_traits(sorted_results)
    if current_user
      personality = current_user.build_personality(traits: top_traits)
      current_user.save
      redirect_to view_results_path
    else
      personality = Personality.new(traits: top_traits)
      personality.save
      session[:user_personality] = personality.id
      redirect_to new_session_path, notice:'Sign In/Sign up to view and save your survey!'
    end
  end

  def view_results
    if current_user && current_user.personality
       @personality = current_user.personality
    else
      redirect_to take_survey_path, notice:'Please take the survey to see your innovator type!'
    end
  end

  protected

    def get_top_traits(sorted_results)
      top_traits = []
      sorted_results.each do |top_trait_id, count|
        top_traits << Trait.find(top_trait_id)
      end
      top_traits
    end

    def sort_results(survey_score)
      survey_score.sort_by{|trait_id, count| count}.reverse.first(5)
    end
end
