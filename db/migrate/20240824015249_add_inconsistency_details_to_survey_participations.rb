class AddInconsistencyDetailsToSurveyParticipations < ActiveRecord::Migration[7.0]
  def change
    add_column :survey_participations, :inconsistency_details, :jsonb, default: []
  end
end
