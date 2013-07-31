class AddFullDescriptionToResources < ActiveRecord::Migration
  def change
    add_column :resources, :full_description, :string
  end
end
