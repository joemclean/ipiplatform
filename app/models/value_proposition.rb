class ValueProposition < ActiveRecord::Base
  attr_accessible :name, :description
  has_many :colors
end
