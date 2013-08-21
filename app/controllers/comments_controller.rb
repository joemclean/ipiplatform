class CommentsController < ApplicationController
  before_filter :signed_in?
  before_action :set_resource, only: [:save, :edit, :delete]
  before_action :set_comment, only: [:edit, :delete]

  def save
    comment = Comment.new(user_id: current_user.id, resource_id: @resource.id, text: params[:comment_text])
    if comment.save
      redirect_to @resource, notice: 'Your comment was added successfully!'
    else
      redirect_to @resource, notice: 'Your comment failed to add. Please try again.'
    end
  end

  def delete
    if @comment.destroy
      redirect_to @resource, notice: 'Your comment was successfully deleted!'
    else
      redirect_to @resource, notice: 'Your comment was not successfully deleted. Please try again.'
    end
  end

  private
    def set_comment
      @comment = Comment.find(params[:comment_id].to_i) 
    end
    def set_resource
      @resource = Resource.find(params[:resource_id].to_i)
    end

end
