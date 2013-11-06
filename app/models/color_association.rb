class ColorAssociation < ActiveRecord::Base
  belongs_to :resource
  belongs_to :color

  validates :resource_id, :color_id, presence: true
end
