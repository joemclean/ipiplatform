class AddValuePropositionCategoryIdToColors < ActiveRecord::Migration
  def change
    add_column :colors, :value_proposition_category_id, :integer
  end
end
