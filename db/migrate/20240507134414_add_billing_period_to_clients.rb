class AddBillingPeriodToClients < ActiveRecord::Migration[7.0]
  def change
    add_column :clients, :current_period_start, :datetime
    add_column :clients, :current_period_end, :datetime
  end
end
