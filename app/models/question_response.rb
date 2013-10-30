class QuestionResponse < ActiveRecord::Base
  belongs_to :color
  belongs_to :question

  def implied_color
    Color.find(self.color_id)
  end
end
