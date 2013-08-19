class ResourceFormat < ActiveRecord::Base
  belongs_to :resource
  belongs_to :format

  def format
    Format.find(self.format_id)
  end
end
