class RenameTraitAssociationToColorAssociation < ActiveRecord::Migration
  def change
    rename_table :trait_associations, :color_associations

    remove_column :color_associations, :trait_id
    add_column :color_associations, :color_id, :integer
  end
end
