class PersonalityTrait < ActiveRecord::Base
  belongs_to :trait
  belongs_to :personality
end