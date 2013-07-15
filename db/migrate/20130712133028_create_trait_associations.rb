class CreateTraitAssociations < ActiveRecord::Migration
  def change
    create_table :trait_associations do |t|
      t.integer :trait_id
      t.integer :resource_id

      t.timestamps
    end
  end
end
