class Color < ActiveRecord::Base
  belongs_to :value_proposition
  attr_accessible :name, :description, :image
  validates :name, :description, presence: true
end
