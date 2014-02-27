class Step < ActiveRecord::Base
  has_and_belongs_to_many :resources
  acts_as_list :scope => :value_proposition
  belongs_to :value_proposition
  validates :name, presence: true

  def add_resource(resource)
    self.resources.push(resource)
  end
end
