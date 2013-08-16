class SurveysController < ApplicationController
  

  def take_survey
    @survey = Survey.new
    @survey.generate_questions
    @question_responses = QuestionResponse.all
  end

  def get_results
    survey = Survey.new

    #if i am logged in
      #option 1: I took the survey again (params['answers']) is set
      #option 2: I am viewing the results of a previously take and saved survey
    #if i am not logged in
      #option 1: I took the suvey and am looking at the results (prompt the user to save)
      #option 2: I didn't take the survey, but i want to look at my results, but haven't logged in.


    if params['answers'] # i just took the survey
      @answer_hash = params['answers']
      survey.answers = @answer_hash
      @score_hash = survey.score
      @score_hash = @score_hash.sort_by{|trait_id, count| count}.reverse
      @score_hash = @score_hash.first(4)
      
      if current_user
        current_user.update(personality: @score_hash)
      else
        session[:user_personality] = @score_hash
        redirect_to new_session_path, notice:'Sign In/Sign up to view and save your survey!'
      end
    else # i did not take the survey and am trying to view results
      if current_user && current_user.personality
        @score_hash = current_user.personality
      else
        redirect_to take_survey_path, notice:'Please take the survey to see your innovator-type!'
      end
    end

  end
end
