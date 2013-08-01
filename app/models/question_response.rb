class QuestionResponse < ActiveRecord::Base
  belongs_to :trait
  belongs_to :question

  def implied_trait
    Trait.find(self.trait_id)
  end
end
