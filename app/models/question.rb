class Question < ActiveRecord::Base
  belongs_to :survey
  has_many :question_responses

  def make_responses(id_pair)
    id_pair.each do |id|
      question_responses = Trait.find(id).question_responses #get all responses for trait id
      question_response = question_responses.offset(rand(question_responses.count)).first #choose a random response from the set
      self.question_responses << question_response
    end
  end 
end
