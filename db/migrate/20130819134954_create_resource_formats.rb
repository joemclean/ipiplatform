class CreateResourceFormats < ActiveRecord::Migration
  def change
    create_table :resource_formats do |t|
      t.integer :format_id
      t.integer :resource_id

      t.timestamps
    end
  end
end
