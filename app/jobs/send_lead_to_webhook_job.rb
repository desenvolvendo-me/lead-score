# app/jobs/send_lead_to_webhook_job.rb
class SendLeadToWebhookJob < ApplicationJob
  queue_as :default

  def perform(score)
    webhook_url = score.data['webhook_url']

    if webhook_url.blank?
      Rails.logger.error("Webhook URL is missing for score #{score.id}.")
      return
    end

    begin
      response = HTTParty.post(
        webhook_url,
        body: score.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )

      if response.success?
        Rails.logger.info("Score #{score.id} successfully sent to webhook.")
      else
        Rails.logger.error("Failed to send score #{score.id} to webhook. Response: #{response.body}")
      end
    rescue HTTParty::Error => e
      Rails.logger.error("HTTParty error while sending score #{score.id} to webhook: #{e.message}")
    rescue StandardError => e
      Rails.logger.error("Unexpected error while sending score #{score.id} to webhook: #{e.message}")
    end
  end
end
