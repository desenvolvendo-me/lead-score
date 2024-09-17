class LeadTransmission < ApplicationRecord
  validates :webhook_url, presence: true
  before_save :webhook_url_valid

  private

  def webhook_url_valid
    if webhook_url.present? && !WebhookValidator.valid?(webhook_url)
      errors.add(:webhook_url, 'is not valid')
      throw(:abort) 
    end
  end
end
