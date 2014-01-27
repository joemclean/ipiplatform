class ValuePropositionCategory < ActiveRecord::Base
  has_many :value_propositions, dependent: :destroy
  validates :name, :description, presence: true
  accepts_nested_attributes_for :value_propositions, update_only: true
end
