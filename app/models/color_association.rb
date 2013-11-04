class ColorAssociation < ActiveRecord::Base
  belongs_to :resource
  belongs_to :color

  attr_accessible :color_id, :resource_id

  validates :resource_id, :color_id, presence: true
end
