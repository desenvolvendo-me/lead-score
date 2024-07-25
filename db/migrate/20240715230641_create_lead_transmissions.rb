class CreateLeadTransmissions < ActiveRecord::Migration[7.0]
  def change
    create_table :lead_transmissions do |t|
      t.string :webhook_url
      t.integer :min_score_threshold
      t.integer :max_score_threshold
      t.boolean :active

      t.timestamps
    end
  end
end
