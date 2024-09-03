class Score < ApplicationRecord
  validates :name, presence: true
  validates :value, presence: true

  attribute :data, :jsonb, default: {}

  after_update :check_and_send_lead, if: :saved_change_to_value?

  def to_s
    name
  end

  private

  def check_and_send_lead
    if auto_send_enabled && value >= score_threshold
      SendLeadToWebhookJob.perform_later(self)
    end
  end
end
