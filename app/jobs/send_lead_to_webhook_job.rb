# app/jobs/send_lead_to_webhook_job.rb
class SendLeadToWebhookJob < ApplicationJob
  queue_as :default

  def perform(score)
    webhook_url = score.data['webhook_url']
    if webhook_url.blank?
      Rails.logger.error("Webhook URL is missing for score #{score.id}.")
      return
    end

    # Enviar o POST request para o webhook
    response = HTTParty.post(webhook_url,
                             body: score.to_json,
                             headers: { 'Content-Type' => 'application/json' }
    )

    if response.success?
      Rails.logger.info("Score #{score.id} successfully sent to webhook.")
    else
      Rails.logger.error("Failed to send score #{score.id} to webhook. Response: #{response.body}")

    end
  end
end
