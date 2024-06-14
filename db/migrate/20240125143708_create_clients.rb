class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string :document
      t.references :user

      t.timestamps
    end
  end
end
