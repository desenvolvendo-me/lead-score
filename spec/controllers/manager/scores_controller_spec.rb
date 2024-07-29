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
    it 'sends the CSV file with the correct content type and header' do
      get :export, params: { q: { s: 'value asc' } }

      expect(response.content_type).to eq('text/html; charset=utf-8')
      expect(response.headers['Content-Disposition']).to include('attachment; filename="scores-')
    end
  end
end