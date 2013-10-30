class RemoveTraitIdAddColorIdToQuestionResponses < ActiveRecord::Migration
  def change
    remove_column :question_responses, :trait_id
    add_column :question_responses, :color_id, :integer
  end
end
