class Resource < ActiveRecord::Base

  has_many :value_proposition_associations, dependent: :destroy
  has_many :value_propositions, through: :value_proposition_associations

  has_many :upvotes, :dependent => :destroy
  has_many :bookmarks, :dependent => :destroy
  has_many :users, through: :bookmarks

  belongs_to :user

  has_many :comments
  has_many :users, through: :comments

  has_many :taggings
  has_many :tags, through: :taggings

  validates :name, :description, :full_description, :link, :source, :user_id, presence: true

  mount_uploader :image, ImageUploader
  mount_uploader :file, FileUploader

  def author
    if self.user_id
      author = User.find(self.user_id)
    else
      author = User.new(name: 'IPI Team', email: 'ipi@sidekick.com')
    end
  end

  def user_upvote(current_user)
    Upvote.where("user_id=? and resource_id=?", current_user.id, self.id)
  end

  def self.tagged_with(name)
    Tag.find_by_name!(name).resources
  end

  def self.tag_counts
    Tag.select("tags.*, count(taggings.tag_id) as count").
      joins(:taggings).group("taggings.tag_id")
  end

  def tag_list=(names)
    self[:tag_list] = names

    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end

  end

  def cleaned_link
    if !(self.link.start_with?('http://'))
      return "http://#{self.link}"
    else
      return self.link
    end
  end

  def checked_value_proposition_tags(params, value_proposition)
    if params[:value_proposition_ids].nil?
      self.value_proposition_ids.include?(value_proposition.id)
    else
      self.value_proposition_ids.include?(value_proposition.id) or params[:value_proposition_ids].include?(value_proposition.id.to_s)
    end
  end


  def image_name
    image.url.present? ? image.url : 'DMcclure.png'
  end

  def file_name
    file.url
  end

end
