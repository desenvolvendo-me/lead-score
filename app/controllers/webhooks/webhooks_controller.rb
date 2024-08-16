module Webhooks
  class WebhooksController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :verify_api_token

    def receive
      body = request.body.read
      if body.present?
        begin
          result = SurveyParticipations::Saver.call(JSON.parse(body))

          if result
            render json: {
              message: 'Survey received successfully'
            }, status: :created
          else
            render json: { error: 'Survey is Empty' }, status: :bad_request
          end
        rescue JSON::ParserError => e
          render json: {
            error: 'Invalid JSON format',
            details: e.message
          }, status: :bad_request
        end
      else
        render json: { error: 'Empty request body' }, status: :bad_request
      end
    end

    private

    def verify_api_token
      provided_token = request.headers['Authorization']
      user = User.find_by(api_token: provided_token)

      unless user
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end
  end
end
