class User < ActiveRecord::Base
  has_secure_password

  #attr_accessible :email, :name, :password, :password_confirmation, :avatar
  has_many :resources

  has_many :upvotes, :dependent => :destroy
  
  has_many :bookmarks, :dependent => :destroy
  has_many :resources, through: :bookmarks
  
  validates_uniqueness_of :email
  serialize :personality
  
  def avatar_url
    gravatar_id = Digest::MD5::hexdigest(self.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=150"
  end
        
end
