class Step < ActiveRecord::Base
  has_many :resources
  belongs_to :value_proposition
  validates :name, presence: true
end
