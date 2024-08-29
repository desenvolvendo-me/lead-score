module Manager
  class TokensController < ApplicationController
    before_action :authenticate_user!

    def index
      @tokens = current_user.api_tokens
    end

    def generate
      token_record = generate_token_for_current_user
      respond_to do |format|
        if token_record
          @token = token_record.token
          format.html do
            redirect_to manager_tokens_path, notice: I18n.t('notice.token_generated')
          end
        else
          format.html do
            redirect_to manager_tokens_path, alert: I18n.t('alert.token_generation_failed')
          end
        end
      end
    end

    private

    def generate_token_for_current_user
      token = SecureRandom.hex(20)
      api_token_record = current_user.api_tokens.create(token: token, client: current_user.client)
      if api_token_record.persisted?
        current_user.update(api_token: token)
        current_user.client.update(api_token: token)
        api_token_record
      else
        false
      end
    rescue StandardError
      false
    end
  end
end
