class AddScoreToLeadHistories < ActiveRecord::Migration[7.0]
  def change
    add_reference :lead_histories, :score, null: false, foreign_key: true
  end
end
