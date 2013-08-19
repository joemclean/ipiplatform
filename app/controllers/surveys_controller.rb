class SurveysController < ApplicationController
  

  def take_survey
    @survey = Survey.new
    @survey.generate_questions
    @question_responses = QuestionResponse.all
  end

  def get_results
    @survey = Survey.new

    #if i am logged in
      #option 1: I took the survey again (params['answers']) is set
      #option 2: I am viewing the results of a previously take and saved survey
    #if i am not logged in
      #option 1: I took the suvey and am looking at the results (prompt the user to save)
      #option 2: I didn't take the survey, but i want to look at my results, but haven't logged in.

    if params['answers'] # i just took the survey
      evaluate_responses
      if current_user
        current_user.update(personality: @personality)
      else
        session[:user_personality] = @personality
        redirect_to new_session_path, notice:'Sign In/Sign up to view and save your survey!'
      end
    else # i did not take the survey and am trying to view results
      if current_user && current_user.personality
        view_past_results
      else
        prompt_survey
      end
    end
  end

  def evaluate_responses
    @survey.answers = params['answers']
    survey_score = @survey.score
    @personality = personality_results(survey_score)
  end

  def view_past_results
    @personality = current_user.personality
  end

  def prompt_survey
    redirect_to take_survey_path, notice:'Please take the survey to see your innovator-type!'
  end

  def personality_results(survey_score)
    survey_score.sort_by{|trait_id, count| count}.reverse.first(5)
  end
end
