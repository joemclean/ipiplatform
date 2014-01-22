class CreateValuePropositionCategories < ActiveRecord::Migration
  def change
    create_table :value_proposition_categories do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
