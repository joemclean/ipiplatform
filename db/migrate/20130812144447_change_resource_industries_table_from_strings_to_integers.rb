class ChangeResourceIndustriesTableFromStringsToIntegers < ActiveRecord::Migration
  def up
    remove_column :resource_industries, :resource_id
    add_column :resource_industries, :resource_id, :integer
    remove_column :resource_industries, :industry_id
    add_column :resource_industries, :industry_id, :integer
  end
  def down
    remove_column :resource_industries, :resource_id
    add_column :resource_industries, :resource_id, :string
    remove_column :resource_industries, :resource_id
    add_column :resource_industries, :resource_id, :string
  end
end
