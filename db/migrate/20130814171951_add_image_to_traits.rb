class AddImageToTraits < ActiveRecord::Migration
  def change
    add_column :traits, :image, :string
  end
end
