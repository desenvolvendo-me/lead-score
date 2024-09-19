class DropTasksTable < ActiveRecord::Migration[7.0]
  def change
    def up
      drop_table :tasks
    end

    def down
      create_table :tasks do |t|
        t.string :name
        t.string :description
        t.string :status
        t.references :goal

        t.timestamps
      end
    end
  end
end
