class PersonalitiesController < ApplicationController
  def create
    @personality = User.new(personality_params)
  end

  def update
  end

  private

    def personality_params
      params.require(:personality).permit(:user_id, :answers)
    end
end
