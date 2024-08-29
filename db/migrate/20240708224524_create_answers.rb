class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers do |t|
      t.jsonb :question_answer

      t.timestamps
    end
  end
end
