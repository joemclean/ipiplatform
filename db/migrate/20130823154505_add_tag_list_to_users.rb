class AddTagListToUsers < ActiveRecord::Migration
  def change
    add_column :resources, :tag_list, :string
  end
end
