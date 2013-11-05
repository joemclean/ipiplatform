class BookmarksController < ApplicationController
  before_filter :redirect_if_not_signed_in

  def make_bookmark
    resource = Resource.find(params[:resource_id].to_i)
    bookmark = Bookmark.new(user_id: current_user.id, resource_id: resource.id)
    bookmark.make
    redirect_to resource
  end

  def unmake_bookmark
    resource = Resource.find(params[:resource_id].to_i)
    bookmark = Bookmark.new(user_id: current_user.id, resource_id: resource.id)
    bookmark.unmake
    redirect_to resource
  end
end
