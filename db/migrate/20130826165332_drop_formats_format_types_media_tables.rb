class DropFormatsFormatTypesMediaTables < ActiveRecord::Migration
  def up
    drop_table :media
    drop_table :formats
    drop_table :format_types
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
