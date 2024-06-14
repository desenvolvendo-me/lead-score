class AddFinishDateToDone < ActiveRecord::Migration[7.0]
  def change
    add_column :goals, :finished_at, :datetime
    add_column :tasks, :finished_at, :datetime
  end
end
