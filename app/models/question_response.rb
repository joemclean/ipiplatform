class QuestionResponse < ActiveRecord::Base
  belongs_to :trait
  belongs_to :question
end
