class CreateValuePropositions < ActiveRecord::Migration
  def change
    create_table :value_propositions do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
