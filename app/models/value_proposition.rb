class ValueProposition < ActiveRecord::Base
  has_many :colors
  attr_accessible :name, :description
  validates :name, :description, presence: true
end
