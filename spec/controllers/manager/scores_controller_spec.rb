require 'rails_helper'
require 'csv'

RSpec.describe Manager::ScoresController, type: :controller do
  let!(:user) { create(:user) }
  let!(:score1) { Score.create(name: 'Score 1', value: 10) }
  let!(:score2) { Score.create(name: 'Score 2', value: 20) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'assigns @scores ordered by value asc' do
      get :index, params: { q: {}, s: 'value asc' }
      expect(assigns(:scores)).to eq([score1, score2])
    end

    it 'assigns @scores ordered by value desc' do
      get :index, params: { q: {}, s: 'value desc' }
      expect(assigns(:scores)).to eq([score2, score1])
    end
  end

  describe 'GET #export' do
    it 'sends the CSV file with the correct content type and header' do
      get :export, params: { q: { s: 'value asc' } }
      expect(response.content_type).to eq('text/csv; charset=utf-8')
      expect(response.headers['Content-Disposition']).to include('attachment; filename="scores-')
    end

    it 'contains the correct CSV content' do
      get :export, params: { q: { s: 'value asc' } }
      csv = CSV.parse(response.body)
      expect(csv).to include(['Name', 'Score'])
      expect(csv).to include([score1.name, score1.value.to_s])
      expect(csv).to include([score2.name, score2.value.to_s])
    end
  end

  describe 'POST #manual_send' do
    let(:webhook_url) { 'http://example.com/webhook' }

    before do
      allow(controller).to receive(:send_lead_to_webhook).and_return(double(success?: true, body: ''))
    end

    it 'handles errors gracefully' do
      allow(controller).to receive(:send_lead_to_webhook).and_raise(StandardError, 'Erro de envio')

      post :manual_send, params: { score_ids: [score1.id, score2.id], destination: webhook_url }

      expect(response).to redirect_to(manager_scores_path)
      expect(flash[:alert]).to eq('Falha ao enviar leads: Erro de envio')
    end
  end
end
