class CreateSpectrums < ActiveRecord::Migration
  def change
    create_table :spectrums do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
