class AddValuePropositionCategoryIdToValuePropositions < ActiveRecord::Migration
  def change
    add_column :value_propositions, :value_proposition_category_id, :integer
  end
end
