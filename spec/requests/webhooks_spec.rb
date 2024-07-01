require 'rails_helper'

RSpec.describe 'Webhooks', type: :request do
  describe 'POST /webhooks/receive' do
    let(:valid_headers) do
      {
        'Authorization' => 'your-secret-api-token',
        'Content-Type' => 'application/json'
      }
    end

    let(:random_name) { "User#{rand(1000..9999)}" }
    let(:random_email) { "user#{rand(1000..9999)}@example.com" }
    let(:random_phone) { "123-456-#{rand(1000..9999)}" }
    let(:random_answers) do
      {
        'first answer' => %w[Sim Não].sample,
        'second answer' => %w[Sim Não].sample
      }
    end

    let(:valid_body) do
      {
        lead: {
          name: random_name,
          email: random_email,
          phone: random_phone
        },
        answers: random_answers
      }.to_json
    end

    context 'with valid token and body' do
      it 'returns status 200' do
        post '/webhooks/receive', headers: valid_headers, params: valid_body
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq('Webhook received successfully')
      end
    end

    context 'with invalid token' do
      it 'returns status 401' do
        invalid_headers = valid_headers.merge('Authorization' => 'invalid-token')
        post '/webhooks/receive', headers: invalid_headers, params: valid_body
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)['error']).to eq('Unauthorized')
      end
    end

    context 'with empty request body' do
      it 'returns status 400' do
        post '/webhooks/receive', headers: valid_headers, params: ''
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)['error']).to eq('Empty request body')
      end
    end

    context 'with invalid JSON format' do
      it 'returns status 400' do
        post '/webhooks/receive', headers: valid_headers, params: 'invalid_json'
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)['error']).to eq('Invalid JSON format')
      end
    end
  end
end
