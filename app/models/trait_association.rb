class TraitAssociation < ActiveRecord::Base
  belongs_to :resource
  belongs_to :trait
end
