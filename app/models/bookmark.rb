class Bookmark < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :resources
  
  
  
  def resource
    resource = Resource.find(self.resource_id)
  end
  
  def exists?
    if Bookmark.where("user_id = ? AND resource_id = ?", self.user_id, self.resource_id).count>0
      true
    else
      false
    end
  end
    
  def make
    unless exists?
      self.save
    end
  end
  
  def unmake
    if exists?
      Bookmark.delete_all(user_id: self.user_id, resource_id: self.resource_id)
    end
  end
end
