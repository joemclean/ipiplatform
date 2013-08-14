class User < ActiveRecord::Base
  has_secure_password

  #attr_accessible :email, :name, :password, :password_confirmation
  has_many :resources

  has_many :upvotes, :dependent => :destroy
  
  has_many :bookmarks, :dependent => :destroy
  has_many :resources, through: :bookmarks
  
  validates_uniqueness_of :email
        
end
