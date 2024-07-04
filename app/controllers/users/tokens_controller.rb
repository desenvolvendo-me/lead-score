module Users
  class TokensController < ApplicationController
    before_action :authenticate_user!

    def index
      @token = current_user.api_token
    end

    def generate
      current_user.generate_api_token
      @token = current_user.api_token
      flash[:notice] = "Token generated successfully"
      redirect_to users_generate_token_path
    end
  end
end
