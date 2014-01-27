class ValuePropositionAssociation < ActiveRecord::Base
  belongs_to :resource
  belongs_to :value_proposition

  validates :resource_id, :value_proposition_id, presence: true
end
