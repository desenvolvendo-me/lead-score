require 'rails_helper'

RSpec.describe 'Webhooks', type: :request do
  before do
    User.create!(name: 'User 1',
                 email: 'user1@mail.com',
                 password: '000000',
                 password_confirmation: '000000',
                 confirmed_at: Time.zone.now,
                 api_token: 'your-secret-api-token')
  end

  describe 'POST /webhooks/receive' do
    let(:valid_headers) do
      {
        'Authorization' => 'your-secret-api-token',
        'Content-Type' => 'application/json'
      }
    end

    let(:valid_body) do
      {
        'Além deste, você já comprou outro curso de Programação?': 'Sim',
        'Qual o seu nome?': 'Thales Henrique Cardoso',
        'Qual seu E-mail?': 'thales.milion25@gmail.com'
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

    context 'when the participation is sent correctly' do
      it 'the amount of survey participation increases' do

        expect do
          post '/webhooks/receive', headers: valid_headers, params: valid_body
        end.to change(SurveyParticipation, :count).by(1)
      end

      it 'the json containing the questions and answers is saved correctly' do
        post '/webhooks/receive', headers: valid_headers, params: valid_body

        expect(SurveyParticipation.last.question_answer_pair).to eq(
          {
            'Além deste, você já comprou outro curso de Programação?': 'Sim',
            'Qual o seu nome?': 'Thales Henrique Cardoso',
            'Qual seu E-mail?': 'thales.milion25@gmail.com'
          }.to_json
        )
      end
    end
  end
end
