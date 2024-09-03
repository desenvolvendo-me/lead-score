class Score < ApplicationRecord
  validates :name, presence: true
  validates :value, presence: true

  SCORE_THRESHOLD = 80

  attribute :data, :jsonb, default: {}

  after_update :check_and_send_lead, if: :saved_change_to_value?
  after_save :check_and_send_to_webhook

  def to_s
    name
  end

  private

  def check_and_send_to_webhook
    if self.value >= SCORE_THRESHOLD && !self.sent_to_webhook?
      SendLeadToWebhookJob.perform_later(self)
      update(sent_to_webhook: true)
    end
  end
end

  def check_and_send_lead
    if auto_send_enabled && value >= score_threshold
      SendLeadToWebhookJob.perform_later(self)
    end
  end
end
