# app/services/send_lead_service.rb
class SendLeadService
  def initialize(score, destination)
    @score = score
    @destination = destination
  end

  def call
    response = HTTParty.post(@destination, {
      body: lead_data.to_json,
      headers: { 'Content-Type' => 'application/json' }
    })
    if response.success?
      @score.register_send(@destination)
    else
      log_error(response)
    end
    response
  end

  private

  def lead_data
    {
      name: @score.name,
      value: @score.value,
      data: @score.data
    }
  end

  def log_error(response)
    Rails.logger.error I18n.t('manager.scores.manual_send.webhook_failure', lead_id: @score.id, destination: @destination, error_body: response.body)
  end
end
