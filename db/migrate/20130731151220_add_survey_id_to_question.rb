class AddSurveyIdToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :survey_id, :string
  end
end
