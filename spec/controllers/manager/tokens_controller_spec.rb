require 'rails_helper'

RSpec.describe Manager::TokensController, type: :controller do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'assigns the token to @token' do
      get :index
      expect(assigns(:token)).to eq(user.api_token)
    end
  end

  describe 'POST #generate' do
    it 'generates a new token for the user' do
      old_token = user.api_token
      post :generate
      user.reload
      expect(user.api_token).not_to eq(old_token)
    end

    it 'redirects to the token generation page with a notice' do
      post :generate
      expect(response).to redirect_to(manager_tokens_path)
      expect(flash[:notice]).to eq(I18n.t('notice.token_generated'))
    end
  end
end
