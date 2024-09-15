require 'rails_helper'
require 'webhook_validator'
require 'webmock/rspec'

RSpec.describe WebhookValidator, type: :lib do
  describe '.valid?' do
    let(:real_url) { 'https://webhook.site/valid-url' }
    let(:invalid_url) { 'https://webhook.site/invalid-url' }

    before do
      WebMock.enable!
    end

    after do
      WebMock.disable!
    end

    context 'when the URL is valid and returns a 200 status' do
      before do
        stub_request(:post, real_url)
          .to_return(status: 200, body: "", headers: {})
      end

      it 'retorna true' do
        expect(WebhookValidator.valid?(real_url)).to be true
      end
    end

    context 'when the URL is invalid or returns a non-200 response' do
      before do
        stub_request(:post, invalid_url)
          .to_return(status: 500, body: "", headers: {})
      end

      it 'retorna false' do
        expect(WebhookValidator.valid?(invalid_url)).to be false
      end
    end

    context 'when an exception is raised' do
      before do
        stub_request(:post, real_url)
          .to_raise(StandardError.new('Simulated error'))
      end

      it 'retorna false' do
        expect(WebhookValidator.valid?(real_url)).to be false
      end
    end
  end
end
