class ChangeResourceIndustriesTableFromStringsToIntegers < ActiveRecord::Migration
  def up
    change_column :resource_industries, :resource_id, :integer
    change_column :resource_industries, :industry_id, :integer
  end
  def down
    change_column :resource_industries, :resource_id, :string
    change_column :resource_industries, :industry_id, :string
  end
end
