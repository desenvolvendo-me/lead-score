require 'rails_helper'
require 'csv'

RSpec.describe Manager::ScoresController, type: :controller do
  let!(:user) { create(:user) }
  let!(:scores) { create_list(:score, 5) }

  before do
    sign_in(user)
  end

  describe 'GET #index' do
    it 'assigns @scores ordered by value asc by default' do
      get :index, params: { q: {} }
      expect(assigns(:scores)).to eq(Score.order(value: :asc))
    end

    it 'assigns @scores ordered by value desc when params[:s] is value desc' do
      get :index, params: { q: {}, s: 'value desc' }
      expect(assigns(:scores)).to eq(Score.order(value: :desc))
    end
  end

  describe 'GET #export' do
    it 'generates and sends CSV data' do
      expect(Scoring::ScoreCsvExporter).to receive(:generate).with(Score.all).and_return('csv_data')
      get :export, format: :csv
      expect(response.headers['Content-Disposition']).to include("attachment; filename=\"scores-#{Date.today}.csv\"")
      expect(response.body).to eq('csv_data')
    end

    it 'enqueues ExportScoresJob with current user id and file path' do
      allow(Scoring::ScoreCsvExporter).to receive(:generate).and_return('csv_data')
      expect(ExportScoresJob).to receive(:perform_async).with(user.id, kind_of(String))
      get :export, format: :csv
    end
  end

  describe 'POST #send_csv_email' do
    it 'generates CSV and enqueues ExportScoresJob' do
      allow(Scoring::ScoreCsvExporter).to receive(:generate).and_return('csv_data')
      expect(ExportScoresJob).to receive(:perform_async).with(user.id, kind_of(String))
      post :send_csv_email
      expect(flash[:notice]).to eq('Arquivo CSV enviado por e-mail com sucesso.')
      expect(response).to redirect_to(manager_scores_path)
    end
  end
end
