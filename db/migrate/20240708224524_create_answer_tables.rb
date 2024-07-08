class CreateAnswerTables < ActiveRecord::Migration[7.0]
  def change
    create_table :answer_tables do |t|
      t.jsonb :question_answer

      t.timestamps
    end
  end
end
