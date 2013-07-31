class AddFullTraitDescriptionToTrait < ActiveRecord::Migration
  def change
    add_column :traits, :full_trait_description, :string
  end
end
