class AddSpectrumIdToTrait < ActiveRecord::Migration
  def change
    add_column :traits, :spectrum_id, :integer
  end
end
