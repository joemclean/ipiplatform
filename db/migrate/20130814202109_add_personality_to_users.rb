class AddPersonalityToUsers < ActiveRecord::Migration
  def change
    add_column :users, :personality, :text
  end
end
