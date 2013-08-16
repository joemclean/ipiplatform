class FormatType < ActiveRecord::Base
  has_many :formats
  has_many :media, through: :formats
end
