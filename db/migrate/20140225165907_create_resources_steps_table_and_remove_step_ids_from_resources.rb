class CreateResourcesStepsTableAndRemoveStepIdsFromResources < ActiveRecord::Migration
  def change
    create_table :resources_steps, :id => false do |t|
        t.references :step, :resource
    end

    add_index :resources_steps, [:step_id, :resource_id]

    remove_column :resources, :step_id
  end
end
