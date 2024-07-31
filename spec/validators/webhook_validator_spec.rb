require 'rails_helper'
require 'webhook_validator'
require 'net/http'

RSpec.describe WebhookValidator, type: :lib do
  describe '.valid?' do
    let(:real_url) { 'https://webhook.site/00ec2011-78bd-43bf-b2ef-a3f6f15d86d7' }
    let(:invalid_url) { 'http://example.com/invalid' }


    context 'when the URL is valid' do
      it 'retorna true' do
        expect(WebhookValidator.valid?(real_url)).to be true
      end
    end

    context 'when the URL is invalid or returns a non-200 response' do
      it 'retorna false' do
        expect(WebhookValidator.valid?(invalid_url)).to be false
      end
    end

    context 'when an exception is raised' do
      before do
        allow(Net::HTTP).to receive(:start).with(URI.parse(real_url).hostname, URI.parse(real_url).port, use_ssl: URI.parse(real_url).scheme == 'https')
                                           .and_raise(StandardError.new('Simulated error'))
      end

      it 'retorna false' do
        expect(WebhookValidator.valid?(real_url)).to be false
      end
    end
  end
end
