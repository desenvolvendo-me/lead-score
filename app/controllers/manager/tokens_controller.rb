module Manager
  class TokensController < ApplicationController
    before_action :authenticate_user!

    def index
      @token = current_user.api_token
    end

    def generate
      current_user.generate_api_token
      redirect_to manager_tokens_path, notice: 'Token gerado com sucesso.'
    end
  end
end

