class PersonalityTraits < ActiveRecord::Migration
  def change
    create_table :personality_traits do |t|
      t.integer :personality_id
      t.integer :trait_id
    end
  end
end
