class CreateWeights < ActiveRecord::Migration[7.0]
  def change
    create_table :weights do |t|
      t.string :description
      t.string :status
      t.jsonb :question_answer, null: false

      t.timestamps
    end
  end
end
