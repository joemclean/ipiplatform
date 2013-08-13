class UpvotesController < ApplicationController
  before_filter :signed_in?

  def new
    upvote = Upvote.new
    upvote.user_id = current_user.id
    upvote.resource_id = params[:resource_id].to_i
    upvote.save
    redirect_to resources_path
  end
  
end
