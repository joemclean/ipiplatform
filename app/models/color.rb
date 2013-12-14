class Color < ActiveRecord::Base
  has_many :color_associations, dependent: :destroy
  has_many :resources, through: :color_associations
  has_many :question_responses
  belongs_to :value_proposition

  validates :name, :description, :value_proposition, presence: true

  mount_uploader :image, ImageUploader

  def ids
    color_ids = []
    Color.all.each do |color|
      color_ids << color.id
    end
  end

  def image_name
    image.url.present? ? image.url : default_image
  end

end
