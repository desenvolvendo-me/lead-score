class AddStripeCustomerIdToClients < ActiveRecord::Migration[7.0]
  def change
    add_column :clients, :stripe_customer_id, :string
  end
end
