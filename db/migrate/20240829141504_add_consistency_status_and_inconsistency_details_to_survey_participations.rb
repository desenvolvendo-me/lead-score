class AddConsistencyStatusAndInconsistencyDetailsToSurveyParticipations < ActiveRecord::Migration[7.0]
  def change
    change_table :survey_participations do |t|
      t.string :consistency_status
      t.jsonb :inconsistency_details, default: []
    end
  end
end
