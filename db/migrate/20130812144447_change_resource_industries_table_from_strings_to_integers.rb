class ChangeResourceIndustriesTableFromStringsToIntegers < ActiveRecord::Migration
  def up
    drop_column :resource_industries, :resource_id
    create_column :resource_industries, :resource_id, :integer
    drop_column :resource_industries, :industry_id
    create_column :resource_industries, :industry_id, :integer
  end
  def down
    drop_column :resource_industries, :resource_id
    create_column :resource_industries, :resource_id, :string
    drop_column :resource_industries, :resource_id
    create_column :resource_industries, :resource_id, :string
  end
end
