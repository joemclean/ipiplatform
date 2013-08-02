class Survey < ActiveRecord::Base
  has_many :questions
  attr_accessor :answers

  def score
    answer_ids = strip_ids(@answers)
    count_traits(answer_ids)
  end

  def strip_ids(answers)
    selected_trait_ids = []
    answers.each do |question_number, trait_id|
      selected_trait_ids << trait_id.to_i
    end
    selected_trait_ids
  end

  def count_traits (selected_trait_ids)
    score_hash = {}
    Trait.ids.each do |trait_id|
      selected_trait_count = selected_trait_ids.count(trait_id)
      score_hash[trait_id] = selected_trait_count
    end
    score_hash
  end

  def generate_questions
    trait_ids = Trait.ids
    25.times do
      question = self.questions.build
      id_pair = trait_ids.sample(2)
      question.make_responses(id_pair)
    end
  end
end
