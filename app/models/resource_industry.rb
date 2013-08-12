class ResourceIndustry < ActiveRecord::Base
	belongs_to :resource
	belongs_to :industry
end
