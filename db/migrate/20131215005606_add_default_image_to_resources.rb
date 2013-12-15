class AddDefaultImageToResources < ActiveRecord::Migration
  def change
    add_column :resources, :default_image, :string
  end
end
