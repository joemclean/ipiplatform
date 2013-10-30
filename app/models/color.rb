class Color < ActiveRecord::Base
  belongs_to :value_proposition
  has_many :question_responses
  #has_many :resources, through: :color_associations
  attr_accessible :name, :description, :image
  validates :name, :description, presence: true

  def ids
    color_ids = []
    Color.all.each do |color|
      color_ids << color.id
    end
  end

end
