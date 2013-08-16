class Medium < ActiveRecord::Base
  has_many :formats
  has_many :format_types, through: :formats
  
end
