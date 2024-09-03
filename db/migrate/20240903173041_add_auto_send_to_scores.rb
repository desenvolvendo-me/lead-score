class AddAutoSendToScores < ActiveRecord::Migration[6.1]
  def change
    add_column :scores, :score_threshold, :integer, default: 0
    add_column :scores, :auto_send_enabled, :boolean, default: true
  end
end
