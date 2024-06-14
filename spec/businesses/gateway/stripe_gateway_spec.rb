require 'rails_helper'
require_relative '../../../app/businesses/gateways/stripe_gateway'

RSpec.describe StripeGateway do
  let(:gateway) { StripeGateway.new }
  let(:user) { double('User', id: 123) }
  let(:subscription_id) { 'sub_test_123' }
  let(:plan_type) { 'professional_montlhy' }
  let(:success_url) { 'http://example.com/success' }
  let(:cancel_url) { 'http://example.com/cancel' }
  let(:stripe_error) { Stripe::StripeError.new("Stripe error") }

  before do
    allow(Stripe).to receive(:api_key=)
  end

  describe '#initialize' do
    it 'sets the Stripe API key' do
      expect(Stripe).to receive(:api_key=).with(Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key))
      StripeGateway.new
    end
  end

  describe '#retrieve_recent_invoices' do
    context 'when successful' do
      it 'returns the list of invoices' do
        invoice_data = [double]
        allow(Stripe::Invoice).to receive_message_chain(:list, :data).and_return(invoice_data)
        expect(gateway.retrieve_recent_invoices).to eq(invoice_data)
      end
    end

    context 'when an error occurs' do
      it 'logs the error and returns an empty array' do
        allow(Stripe::Invoice).to receive(:list).and_raise(stripe_error)
        expect(Rails.logger).to receive(:error).with("Stripe Error: Stripe error")
        expect(gateway.retrieve_recent_invoices).to eq([])
      end
    end
  end

  describe '#retrieve_subscription' do
    context 'when successful' do
      it 'returns the subscription' do
        subscription = double
        allow(Stripe::Subscription).to receive(:retrieve).with(subscription_id).and_return(subscription)
        expect(gateway.retrieve_subscription(subscription_id)).to eq(subscription)
      end
    end

    context 'when an error occurs' do
      it 'logs the error and returns nil' do
        allow(Stripe::Subscription).to receive(:retrieve).and_raise(stripe_error)
        expect(Rails.logger).to receive(:error).with("Stripe Error: Stripe error")
        expect(gateway.retrieve_subscription(subscription_id)).to be_nil
      end
    end
  end

  describe '#retrieve_plan_details' do
    let(:subscription) { double(items: double(data: [double(plan: double(product: 'prod_123', name: 'Plan', interval: 'monthly', amount: 1000))])) }
    let(:product) { double(name: 'Plan') }

    context 'when successful' do
      it 'returns plan details' do
        allow(Stripe::Product).to receive(:retrieve).and_return(product)
        result = gateway.retrieve_plan_details(subscription)
        expect(result).to eq({name: 'Plan', interval: 'monthly', amount: 10.0})
      end
    end

    context 'when there is no plan data' do
      let(:subscription) { double(items: double(data: [])) }
      it 'returns default plan details' do
        result = gateway.retrieve_plan_details(subscription)
        expect(result).to eq({name: "Desconhecido", interval: "Desconhecido", amount: "Indisponível"})
      end
    end

    context 'when an error occurs' do
      it 'logs the error and returns error details' do
        allow(Stripe::Product).to receive(:retrieve).and_raise(stripe_error)
        expect(Rails.logger).to receive(:error).with("Stripe Error: Stripe error")
        result = gateway.retrieve_plan_details(subscription)
        expect(result).to eq({name: "Erro ao recuperar o plano", interval: "Desconhecido", amount: "Indisponível"})
      end
    end
  end

end
