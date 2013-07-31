class QuestionResponsesController < ApplicationController
  before_action :set_question_response, only: [:edit, :update, :destroy]

  def new
    @question_response = QuestionResponse.new
  end

  def create
    @question_response = QuestionResponse.new(question_response_params)
    if @question_response.save
      redirect_to question_responses_path, notice: 'Resource was successfully created.'
    else
      #
    end
  end

  def index
    @question_responses = QuestionResponse.all
  end

  def destroy
    @question_response.destroy
    redirect_to question_responses_path
  end

  def edit
  end

  def update
    if @question_response.update(question_response_params)
      redirect_to question_responses_path, notice: 'Question response was successfully updated.'
    else
      #
    end
  end

  private

    def question_response_params
      params.require(:question_response).permit(:response, :trait_id)
    end

    def set_question_response
      @question_response = QuestionResponse.find(params[:id])
    end


end
