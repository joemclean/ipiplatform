class PhaseAssociation < ActiveRecord::Base
  belongs_to :resource
  belongs_to :phase
end
