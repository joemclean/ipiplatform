class Survey < ActiveRecord::Base
  has_many :questions
  attr_accessor :answers

  def score
    answer_ids = strip_ids(@answers)
    count_traits(answer_ids)
  end

  def strip_ids(answers) #get trait ids, remove question numbers
    answer_ids = []
    answers.each do |question_number, trait_id|
      answer_ids << trait_id.to_i
    end
    answer_ids
  end

  def count_traits (answer_ids)
    score_hash = {}
    Trait.ids.each do |trait_id|
      answer_count = answer_ids.count(trait_id)
      score_hash[trait_id] = answer_count
    end
    score_hash
  end
end
