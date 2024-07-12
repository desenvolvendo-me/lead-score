class CreateScores < ActiveRecord::Migration[7.0]
  def change
    create_table :scores do |t|
      t.string :name
      t.integer :value

      t.timestamps
    end
  end
end
