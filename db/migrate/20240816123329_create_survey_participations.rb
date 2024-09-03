class CreateSurveyParticipations < ActiveRecord::Migration[7.0]
  def change
    create_table :survey_participations do |t|
      t.jsonb :question_answer_pair

      t.timestamps
    end
  end
end
