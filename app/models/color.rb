class Color < ActiveRecord::Base
  has_many :color_associations
  has_many :resources, through: :color_associations
  has_many :question_responses
  belongs_to :value_proposition

  attr_accessible :name, :description, :image
  validates :name, :description, presence: true

  def ids
    color_ids = []
    Color.all.each do |color|
      color_ids << color.id
    end
  end

end
