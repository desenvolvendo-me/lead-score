module Users
  class TokensController < ApplicationController
    before_action :authenticate_user!

    def index
      # Exibe a página para gerar o token
    end

    def generate
      current_user.update(api_token: SecureRandom.hex(20))
      redirect_to users_tokens_path, notice: "Token gerado com sucesso."
    end
  end
end

