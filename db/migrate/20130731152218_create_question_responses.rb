class CreateQuestionResponses < ActiveRecord::Migration
  def change
    create_table :question_responses do |t|
      t.text :response
      t.integer :trait_id

      t.timestamps
    end
  end
end
