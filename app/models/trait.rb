class Trait < ActiveRecord::Base
  has_many :trait_associations
  has_many :resources, through: :trait_associations
  has_many :question_responses

  def ids
    trait_ids = []
    Trait.all.each do |trait|
      trait_ids << trait.id
    end
  end
end
