class CreateFormats < ActiveRecord::Migration
  def change
    create_table :formats do |t|
      t.integer :medium_id
      t.integer :format_type_id

      t.timestamps
    end
  end
end
