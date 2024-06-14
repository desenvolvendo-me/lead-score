require 'rails_helper'

RSpec.describe CheckoutController, type: :controller do
  let(:client) { double('Client') }
  let(:user) { double('User', id: 123, client: client) }
  let(:session_url) { 'http://example.com/checkout_session' }
  let(:session) { double('Stripe::Checkout::Session', url: session_url) }

  before do
    allow(controller).to receive(:current_user).and_return(user)
    allow(controller).to receive(:checkout_success_url).and_return('http://example.com/success')
    allow(controller).to receive(:checkout_cancel_url).and_return('http://example.com/cancel')
  end

  describe 'POST #create' do
    context 'when checkout session is successfully created' do
      before do
        allow_any_instance_of(StripeGateway).to receive(:create_checkout_session).and_return(session)
      end

      it 'redirects to the Stripe session URL' do
        post :create, params: { plan: 'basic' }
        expect(response).to redirect_to(session_url)
      end
    end

    context 'when checkout session creation fails' do
      before do
        allow_any_instance_of(StripeGateway).to receive(:create_checkout_session).and_return(nil)
      end

      it 'sets a flash error and redirects to the pricing page' do
        post :create, params: { plan: 'basic' }
        expect(flash[:error]).to eq('Houve um problema ao criar a sessão de checkout.')
        expect(response).to redirect_to(pricing_path)
      end
    end
  end

  describe 'GET #success' do
    it 'renders the success template' do
      get :success
      expect(response).to render_template('checkout/success')
    end
  end

  describe 'GET #cancel' do
    it 'renders the cancel template' do
      get :cancel
      expect(response).to render_template('checkout/cancel')
    end
  end
end
