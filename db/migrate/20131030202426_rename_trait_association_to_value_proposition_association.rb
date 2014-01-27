class RenameTraitAssociationToValuePropositionAssociation < ActiveRecord::Migration
  def change
    rename_table :trait_associations, :value_proposition_associations

    remove_column :value_proposition_associations, :trait_id
    add_column :value_proposition_associations, :value_proposition_id, :integer
  end
end
