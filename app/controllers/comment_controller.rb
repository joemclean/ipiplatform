class CommentController < ApplicationController
  before_filter :signed_in?

  def save_comment
    resource = Resource.find(params[:resource_id].to_i)
    comment = Comment.new()
    comment.user_id = current_user.id
    comment.resource_id = resource.id
    comment.text = params[:text]
    if comment.save
      redirect_to resource, notice: 'Your comment was added successfully!'
    else
      redirect_to resource, notice: 'Your comment failed to add. Please try again.'
    end
  end

  def delete_comment
  end

  def edit_comment
  end
end
