class AddApiTokenToClients < ActiveRecord::Migration[7.0]
  def change
    add_column :clients, :api_token, :string
  end
end
