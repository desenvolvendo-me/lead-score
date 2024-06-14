class AddClientToGoals < ActiveRecord::Migration[7.0]
  def change
    add_column :goals, :client_id, :integer
  end
end
