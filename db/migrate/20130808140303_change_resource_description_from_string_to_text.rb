class ChangeResourceDescriptionFromStringToText < ActiveRecord::Migration
  def change
    def up
      change_column :resource, :full_description, :text
    end
    def down
      # This might cause trouble if you have strings longer
      # than 255 characters.
      change_column :resource, :full_description, :string
    end
  end
end
