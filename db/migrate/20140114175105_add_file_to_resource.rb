class AddFileToResource < ActiveRecord::Migration
  def change
    add_column :resources, :file, :string
  end
end
