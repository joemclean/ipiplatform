class User < ActiveRecord::Base
  has_secure_password

  has_many :resources
  has_many :upvotes, :dependent => :destroy
  has_many :bookmarks, :dependent => :destroy
  has_many :resources, through: :bookmarks
  has_one :personality

  has_many :comments

  validates_uniqueness_of :email
  
  def avatar_url
    gravatar_id = Digest::MD5::hexdigest(self.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=150"
  end

  def can_edit_and_delete_resource? current_user, resource
    current_user.id.eql? resource.user_id or current_user.is_admin?
  end
        
end
