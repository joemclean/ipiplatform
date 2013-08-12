class CreateResourceIndustries < ActiveRecord::Migration
  def change
    create_table :resource_industries do |t|
      t.string :resource_id
      t.string :industry_id

      t.timestamps
    end
  end
end
