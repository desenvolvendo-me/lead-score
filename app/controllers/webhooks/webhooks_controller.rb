module Webhooks
  class WebhooksController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :verify_api_token

    def receive
      body = request.body.read
      if body.present?
        begin
          data = JSON.parse(body)
          if missing_required_fields?(data)
            missing_fields = find_missing_fields(data)
            Rails.logger.error "Missing required fields: #{missing_fields.join(', ')}"
            render json: {
              error: 'Missing required fields',
              missing_fields: missing_fields
            }, status: :bad_request
          else
            Rails.logger.info "Received webhook data: #{data}"
            render json: {
              message: 'Webhook received successfully'
            }, status: :ok
          end
        rescue JSON::ParserError => e
          Rails.logger.error "JSON::ParserError: #{e.message}"
          render json: {
            error: 'Invalid JSON format',
            details: e.message
          }, status: :bad_request
        end
      else
        Rails.logger.error 'Empty request body'
        render json: { error: 'Empty request body' }, status: :bad_request
      end
    end

    private

    # TO DO: Implement authentication in the next task
    def verify_api_token
      provided_token = request.headers['Authorization']
      expected_token = 'your-secret-api-token'

      unless ActiveSupport::SecurityUtils.secure_compare(provided_token, expected_token)
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end

    def missing_required_fields?(data)
      required_fields = %w[lead lead.name lead.email lead.phone answers]
      required_fields.any? do |field|
        keys = field.split('.')
        value = safe_dig(data, keys)
        value.nil?
      end
    end

    def find_missing_fields(data)
      required_fields = %w[lead lead.name lead.email lead.phone answers]
      required_fields.select do |field|
        keys = field.split('.')
        value = safe_dig(data, keys)
        value.nil?
      end
    end

    def safe_dig(hash, keys)
      keys.reduce(hash) do |acc, key|
        acc.is_a?(Hash) ? acc[key] : nil
      end
    rescue StandardError
      nil
    end
  end
end
