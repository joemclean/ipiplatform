class BookmarksController < ApplicationController
  before_filter :signed_in?


  # POST /bookmarks
  # POST /bookmarks.json
  def make_bookmark
    resource = Resource.find(params[:resource_id].to_i)
    bookmark = Bookmark.new(user_id: current_user.id, resource_id: resource.id)
    bookmark.make
    
    redirect_to resource
  end

  # DELETE /bookmarks/1
  # DELETE /bookmarks/1.json
  def unmake_bookmark
    resource = Resource.find(params[:resource_id].to_i)
    bookmark = Bookmark.new(user_id: current_user.id, resource_id: resource.id)
    bookmark.unmake
    
    redirect_to resource
  end
end
