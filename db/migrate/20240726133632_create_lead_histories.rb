class CreateLeadHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :lead_histories do |t|
      t.datetime :sent_at
      t.string :destination
      t.string :lead

      t.timestamps
    end
  end
end
