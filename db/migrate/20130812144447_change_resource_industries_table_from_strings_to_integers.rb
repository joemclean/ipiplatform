class ChangeResourceIndustriesTableFromStringsToIntegers < ActiveRecord::Migration
  def up
    remove_column :resource_industries, :resource_id
    create_column :resource_industries, :resource_id, :integer
    remove_column :resource_industries, :industry_id
    create_column :resource_industries, :industry_id, :integer
  end
  def down
    remove_column :resource_industries, :resource_id
    create_column :resource_industries, :resource_id, :string
    remove_column :resource_industries, :resource_id
    create_column :resource_industries, :resource_id, :string
  end
end
