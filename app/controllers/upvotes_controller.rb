class UpvotesController < ApplicationController
  before_filter :signed_in?

  def create
    upvote = Upvote.new
    upvote.user_id = current_user.id
    upvote.resource_id = params[:resource_id].to_i
    resource = Resource.find(params[:resource_id].to_i)
    if resource.user_upvote(current_user).count > 0
      raise 'already has upvote'
    else
      upvote.save
      redirect_to resource
    end
  end

  def clear_upvote
    resource = Resource.find(params[:resource_id])
    Upvote.delete_all(user_id: current_user.id, resource_id: resource.id)
    redirect_to resource
  end
end
