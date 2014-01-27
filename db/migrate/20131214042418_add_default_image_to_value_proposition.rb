class AddDefaultImageToValueProposition < ActiveRecord::Migration
  def change
    add_column :value_propositions, :default_image, :string
  end
end
