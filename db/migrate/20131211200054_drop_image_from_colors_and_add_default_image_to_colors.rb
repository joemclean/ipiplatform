class DropImageFromColorsAndAddDefaultImageToColors < ActiveRecord::Migration
  def change
    remove_column :colors, :image
    add_column :colors, :default_image, :string
  end
end
