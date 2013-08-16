class CreateFormatTypes < ActiveRecord::Migration
  def change
    create_table :format_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
