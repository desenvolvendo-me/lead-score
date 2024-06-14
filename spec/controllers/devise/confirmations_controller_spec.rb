require 'rails_helper'

RSpec.describe Devise::ConfirmationsController, type: :controller do
  describe '#show' do
    let(:user) { create(:user, confirmed_at: nil) }
    let(:confirmation_token) { 'confirmation_token' }

    before do
      allow(controller).to receive(:resource_class).and_return(User)
      @request.env['devise.mapping'] = Devise.mappings[:user]
    end

    context 'when confirmation is successful' do
      it 'redirects to the new user session path with a confirmation notice' do
        allow(User).to receive(:confirm_by_token)
          .with(confirmation_token).and_return(user)
        allow(user.errors).to receive(:empty?).and_return(true)

        get :show, params: { confirmation_token: confirmation_token }
        expect(response).to redirect_to(new_user_session_path)
        expect(flash[:notice]).to eq(I18n.t('devise.confirmations.confirmed'))
      end
    end

    context 'when confirmation fails' do
      it 'redirects to the new user session path with an unconfirmed notice' do
        allow(User).to receive(:confirm_by_token)
          .with(confirmation_token).and_return(user)
        allow(user.errors).to receive(:empty?).and_return(false)

        get :show, params: { confirmation_token: confirmation_token }
        expect(response).to redirect_to(new_user_session_path)
        expect(flash[:notice]).to eq(I18n.t('devise.failure.unconfirmed'))
      end
    end
  end
end
