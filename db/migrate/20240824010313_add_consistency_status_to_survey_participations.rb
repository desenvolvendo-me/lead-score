class AddConsistencyStatusToSurveyParticipations < ActiveRecord::Migration[7.0]
  def change
    add_column :survey_participations, :consistency_status, :string
  end
end
