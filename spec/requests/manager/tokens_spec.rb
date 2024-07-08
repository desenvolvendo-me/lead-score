require 'rails_helper'

RSpec.describe 'Tokens', type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe 'GET /manager/tokens' do
    it 'returns http success' do
      get manager_tokens_path
      expect(response).to have_http_status(:success)
    end

    it 'assigns the token to @token' do
      get manager_tokens_path
      expect(assigns(:token)).to eq(user.api_token)
    end
  end

  describe 'POST /manager/generate_token' do
    it 'generates a new token for the user' do
      old_token = user.api_token
      post manager_tokens_generate_token_path
      user.reload
      expect(user.api_token).not_to eq(old_token)
    end

    it 'redirects to the token generation page with a notice' do
      post manager_tokens_generate_token_path
      expect(response).to redirect_to(manager_tokens_path)
      follow_redirect!
      expect(flash[:notice]).to eq('Token gerado com sucesso.')
    end
  end
end
