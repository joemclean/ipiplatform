class Step < ActiveRecord::Base
  has_many :resources
  acts_as_list :scope => :value_proposition
  belongs_to :value_proposition
  validates :name, presence: true
end
