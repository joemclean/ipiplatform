class CreatePersonalities < ActiveRecord::Migration
  def change
    create_table :personalities do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
