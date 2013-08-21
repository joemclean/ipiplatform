class Comment < ActiveRecord::Base
  belongs_to :resource
  belongs_to :user

  def author
    User.find(self.user_id)
  end

end
