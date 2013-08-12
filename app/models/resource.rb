class Resource < ActiveRecord::Base
  has_many :trait_associations
  has_many :traits, through: :trait_associations
  has_many :resource_industries
  has_many :industries, through: :resource_industries

  belongs_to :user

  def author
    if self.user_id
      author = User.find(self.user_id)
    else
      author = User.new(name: 'IPI Team', email: 'ipi@sidekick.com')
    end
  end


end
