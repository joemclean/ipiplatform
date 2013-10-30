class SurveysController < ApplicationController
  

  def take_survey
    @survey = Survey.new
    @survey.generate_questions
    @question_responses = QuestionResponse.all
  end

  def get_results
    survey = Survey.new(answers: params['answers'])
    survey_results = survey.score
    top_colors = get_top_colors(survey_results)
    if current_user
      personality = current_user.build_personality(colors: top_colors)
      current_user.save
      redirect_to view_results_path
    else
      personality = Personality.new(colors: top_colors)
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

    def get_top_colors(sorted_results)
      top_colors = []
      sorted_results.each do |top_color_id, count|
        top_colors << Color.find(top_color_id)
      end
      top_colors
    end
end
