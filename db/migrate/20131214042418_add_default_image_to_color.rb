class AddDefaultImageToColor < ActiveRecord::Migration
  def change
    add_column :colors, :default_image, :string
  end
end
