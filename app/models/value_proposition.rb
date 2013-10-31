class ValueProposition < ActiveRecord::Base
  has_many :colors
  attr_accessible :name, :description
  validates :name, :description, presence: true
  accepts_nested_attributes_for :colors, update_only: true
end
