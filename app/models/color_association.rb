class ColorAssociation < ActiveRecord::Base
  belongs_to :resource
  belongs_to :color
end
