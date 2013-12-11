class Color < ActiveRecord::Base
  has_many :color_associations, dependent: :destroy
  has_many :resources, through: :color_associations
  has_many :question_responses
  belongs_to :value_proposition
  mount_uploader :image, ImageUploader

  validates :name, :description, :value_proposition, presence: true

  def ids
    color_ids = []
    Color.all.each do |color|
      color_ids << color.id
    end
  end

  def image_name
    image.size.present? ? File.basename(image.path || image.filename) : image
  end

end
