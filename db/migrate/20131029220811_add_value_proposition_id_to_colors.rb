class AddValuePropositionIdToColors < ActiveRecord::Migration
  def change
    add_column :colors, :value_proposition_id, :integer
  end
end
