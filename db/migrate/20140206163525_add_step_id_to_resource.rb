class AddStepIdToResource < ActiveRecord::Migration
  def change
    add_column :resources, :step_id, :integer
  end
end
