class Color < ActiveRecord::Base
  attr_accessible :name, :description, :image
  belongs_to :value_proposition
end
