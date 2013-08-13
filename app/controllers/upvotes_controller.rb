class UpvotesController < ApplicationController
  before_filter :signed_in?

  def create
    upvote = Upvote.new
    upvote.user_id = current_user.id
    upvote.resource_id = params[:resource_id].to_i
    upvote.save

    respond_to do |format|
      format.html { redirect_to resources_path }
      format.js
    end
  end
  
end
