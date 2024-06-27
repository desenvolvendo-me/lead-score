module Webhooks
  class WebhooksController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :verify_api_token

    def receive
      body = request.body.read
      if body.present?
        begin
          data = JSON.parse(body)
          Rails.logger.info "Received webhook data: #{data}"

          render json: { message: 'Webhook received successfully' }, status: :ok
        rescue JSON::ParserError => e
          Rails.logger.error "JSON::ParserError: #{e.message}"
          render json: { error: 'Invalid JSON format' }, status: :bad_request
        end
      else
        Rails.logger.error 'Empty request body'
        render json: { error: 'Empty request body' }, status: :bad_request
      end
    end

    private

    def verify_api_token
      provided_token = request.headers['Authorization']
      expected_token = 'your-secret-api-token'

      unless ActiveSupport::SecurityUtils.secure_compare(provided_token, expected_token)
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end
  end
end
