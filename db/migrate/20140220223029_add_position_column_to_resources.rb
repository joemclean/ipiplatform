class AddPositionColumnToResources < ActiveRecord::Migration
  def change
    add_column :resources, :position, :integer
  end
end
