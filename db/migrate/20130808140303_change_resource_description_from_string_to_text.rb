class ChangeResourceDescriptionFromStringToText < ActiveRecord::Migration
  def up
    change_column :resources, :full_description, :text, :limit => nil
  end
  def down
    # This might cause trouble if you have strings longer
    # than 255 characters.
    change_column :resources, :full_description, :string
  end
end
