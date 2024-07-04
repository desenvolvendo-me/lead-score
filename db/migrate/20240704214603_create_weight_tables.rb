class CreateWeightTables < ActiveRecord::Migration[7.0]
  def change
    create_table :weight_tables do |t|
      t.string :description
      t.string :status
      t.jsonb :question_answer, null: false, default: '{}'

      t.timestamps
    end
  end
end
