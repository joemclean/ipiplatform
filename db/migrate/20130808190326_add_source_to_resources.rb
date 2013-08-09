class AddSourceToResources < ActiveRecord::Migration
  def change
    add_column :resources, :source, :string
  end
end
