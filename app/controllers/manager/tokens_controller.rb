module Manager
  class TokensController < ApplicationController
    before_action :authenticate_user!

    def index
      @tokens = current_user.api_tokens
    end

    def generate
      respond_to do |format|
        if generate_token_for_current_user
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
      current_user.api_tokens.create(token: SecureRandom.hex(20), client: current_user.client)
    rescue StandardError
      false
    end
  end
end
