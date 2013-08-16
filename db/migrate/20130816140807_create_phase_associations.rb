class CreatePhaseAssociations < ActiveRecord::Migration
  def change
    create_table :phase_associations do |t|
      t.integer :phase_id
      t.integer :resource_id
    end
  end
end
