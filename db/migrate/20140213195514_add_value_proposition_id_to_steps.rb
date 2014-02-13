class AddValuePropositionIdToSteps < ActiveRecord::Migration
  def change
    add_column :steps, :value_proposition_id, :integer
  end
end
