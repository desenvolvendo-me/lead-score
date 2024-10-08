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
  describe 'GET #index' do
    it 'assigns @scores' do
      expect(assigns(:scores)).to eq(Score.all)
    end

    it 'assigns @scores to not be nil' do
      expect(assigns(:scores)).to_not be_nil
    end

      expect(response.content_type).to eq('text/csv; charset=utf-8')
      expect(response.headers['Content-Disposition']).to include('attachment; filename="scores-')
    end
  end
end