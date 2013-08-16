class Format < ActiveRecord::Base
  belongs_to :format_type
  belongs_to :medium

  def medium
    Medium.find(self.medium_id)
  end
  
  def format_type
    FormatType.find(self.format_type_id)
  end

end
