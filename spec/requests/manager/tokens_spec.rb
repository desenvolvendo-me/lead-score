require 'rails_helper'

RSpec.describe 'Tokens', type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { create(:user) }
  let(:client) { create(:client, user: user) }

  before do
    user.update(client: client) # Certifique-se de que o usuário tem um cliente associado
    sign_in user
  end

  describe 'GET /manager/tokens' do
    it 'returns http success' do
      get manager_tokens_path
      expect(response).to have_http_status(:success)
    end

    it 'assigns the tokens to @tokens' do
      get manager_tokens_path
      expect(assigns(:tokens)).to eq(user.api_tokens)
    end
  end

  describe 'POST /manager/tokens/generate_token' do
    it 'generates a new token for the user' do
      expect {
        post manager_tokens_generate_token_path
      }.to change { user.api_tokens.count }.by(1)
    end

    it 'redirects to the token generation page with a notice' do
      post manager_tokens_generate_token_path
      follow_redirect!
      expect(flash[:notice]).to eq(I18n.t('notice.token_generated'))
    end

    it 'handles token generation failure gracefully' do
      allow_any_instance_of(User).to receive(:api_tokens).and_raise(StandardError.new("Simulated failure"))
      post manager_tokens_generate_token_path
      expect(flash[:alert]).to eq(I18n.t('alert.token_generation_failed'))
    end
  end
end
