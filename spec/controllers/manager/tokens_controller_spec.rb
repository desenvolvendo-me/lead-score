require 'rails_helper'

RSpec.describe Manager::TokensController, type: :controller do
  let(:user) { create(:user) }
  let(:client) { create(:client, user: user) }

  before do
    user.update(client: client)
    sign_in user
  end

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'assigns the tokens to @tokens' do
      get :index
      expect(assigns(:tokens)).to eq(user.api_tokens)
    end
  end

  describe 'POST #generate' do
    it 'generates a new token for the user' do
      expect {
        post :generate
      }.to change { user.api_tokens.count }.by(1)
    end

    it 'redirects to the token generation page with a notice' do
      post :generate
      expect(response).to redirect_to(manager_tokens_path)
      expect(flash[:notice]).to eq(I18n.t('notice.token_generated'))
    end

    it 'handles token generation failure gracefully' do
      allow_any_instance_of(User).to receive(:api_tokens).and_raise(StandardError.new("Simulated failure"))
      post :generate
      expect(flash[:alert]).to eq(I18n.t('alert.token_generation_failed'))
    end
  end
end
