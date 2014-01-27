class ValueProposition < ActiveRecord::Base
  has_many :value_proposition_associations, dependent: :destroy
  has_many :resources, through: :value_proposition_associations
  belongs_to :value_proposition_category

  validates :name, :description, :value_proposition_category, presence: true

  mount_uploader :image, ImageUploader

  def ids
    value_proposition_ids = []
    ValueProposition.all.each do |value_proposition|
      value_proposition_ids << value_proposition.id
    end
  end

  def image_name
    image.url.present? ? image.url : default_image
  end

end
