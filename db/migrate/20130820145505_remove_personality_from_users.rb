class RemovePersonalityFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :personality
  end
  def down
    #need to edit model to serialize to work properly
    add_column :users, :personality, :text
  end
end
