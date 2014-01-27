class CreateValuePropositions < ActiveRecord::Migration
  def change
    create_table :value_propositions do |t|
      t.string :name
      t.string :description
      t.string :image

      t.timestamps
    end
  end
end
