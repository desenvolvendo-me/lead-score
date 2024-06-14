class CreateGoals < ActiveRecord::Migration[7.0]
  def change
    create_table :goals do |t|
      t.string :name
      t.string :description
      t.string :status


      t.timestamps
    end
  end
end
