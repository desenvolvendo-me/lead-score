require 'rails_helper'
require 'csv'

RSpec.describe Manager::ScoresController, type: :controller do
  let!(:user) { create(:user) }
  let!(:score1) { Score.create(name: 'Score 1', value: 10) }
  let!(:score2) { Score.create(name: 'Score 2', value: 20) }

  before do
    sign_in user
  end

  describe 'GET #export' do
    it 'exports scores to CSV and sends the file' do
      get :export, params: { q: { s: 'value asc' } }

      expect(response.content_type).to eq('text/html; charset=utf-8')

      expect(response.headers['Content-Disposition']).to include('scores-')

      csv = CSV.parse(response.body, headers: true)
      expect(csv.headers).to include('Name', 'Score')
      expect(csv.find { |row| row['Name'] == 'Score 1' }['Score']).to eq('10')
      expect(csv.find { |row| row['Name'] == 'Score 2' }['Score']).to eq('20')
    end
  end
end
