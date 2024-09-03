require 'rails_helper'

RSpec.describe Webhooks::WebhooksController, type: :controller do
  before do
    User.create!(name: 'User 1',
                 email: 'user1@mail.com',
                 password: '000000',
                 password_confirmation: '000000',
                 confirmed_at: Time.zone.now,
                 api_token: 'your-secret-api-token')
  end

  describe 'POST #receive' do
    let(:valid_headers) do
      {
        'Authorization' => 'your-secret-api-token',
        'Content-Type' => 'application/json'
      }
    end

    let(:valid_body) do
      [
        {
          '0' => 'Time',
          '1' => 'Question 1',
          '2' => 'Question 2',
          '3' => 'Question 3'
        },
        {
          '0' => FFaker::Time.datetime,
          '1' => %w[yes not].sample,
          '2' => FFaker::Name.name,
          '3' => FFaker::Internet.email
        },
        {
          '0' => FFaker::Time.datetime,
          '1' => %w[yes not].sample,
          '2' => FFaker::Name.name,
          '3' => FFaker::Internet.email
        },
        {
          '0' => FFaker::Time.datetime,
          '1' => %w[yes not].sample,
          '2' => FFaker::Name.name,
          '3' => FFaker::Internet.email
        }
      ].to_json
    end

    let(:invalid_body) do
      {}.to_json
    end

    context 'with valid token and body' do
      context 'when Survey was received correctly' do
        it 'returns status 201' do
          request.headers.merge!(valid_headers)
          post :receive, body: valid_body

          expect(response).to have_http_status(:created)
          expect(JSON.parse(response.body)['message'])
            .to eq('Survey received successfully')
        end
      end

      context 'when Survey was not received' do
        it 'returns status 400' do
          request.headers.merge!(valid_headers)
          post :receive, body: invalid_body

          expect(response).to have_http_status(:bad_request)
          expect(JSON.parse(response.body)['error'])
            .to eq('Survey is Empty')
        end
      end
    end

    context 'with invalid token' do
      it 'returns status 401' do
        request.headers['Authorization'] = 'invalid-token'
        post :receive, body: valid_body
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)['error']).to eq('Unauthorized')
      end
    end

    context 'with empty request body' do
      it 'returns status 400' do
        request.headers.merge!(valid_headers)
        post :receive, body: ''
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)['error']).to eq('Empty request body')
      end
    end

    context 'with invalid JSON format' do
      it 'returns status 400' do
        request.headers.merge!(valid_headers)
        post :receive, body: 'invalid_json'
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)['error']).to eq('Invalid JSON format')
      end
    end
  end
end
