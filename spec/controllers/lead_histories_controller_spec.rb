require 'rails_helper'

RSpec.describe LeadHistoriesController, type: :controller do
  describe 'GET #index' do
    let!(:score1) { create(:score, name: 'Maria') }
    let!(:score2) { create(:score, name: 'José') }
    let!(:lead_history1) { create(:lead_history, score: score1, sent_at: 1.day.ago) }
    let!(:lead_history2) { create(:lead_history, score: score2, sent_at: 2.days.ago) }
    let!(:lead_history3) { create(:lead_history, score: score1, sent_at: 3.days.ago) }

    context 'without filters' do
      it 'returns all lead histories ordered by sent_at descending' do
        get :index

        expect(assigns(:lead_histories)).to match_array([lead_history1, lead_history2, lead_history3])
        expect(assigns(:lead_histories).map(&:sent_at)).to eq([lead_history1.sent_at, lead_history2.sent_at, lead_history3.sent_at].sort.reverse)
      end
    end

    context 'with search filter' do
      it 'returns lead histories filtered by score name' do
        get :index, params: { search: 'Maria' }

        expect(assigns(:lead_histories)).to match_array([lead_history1, lead_history3])
      end
    end

    context 'with date range filter' do
      it 'returns lead histories filtered by sent_at date range' do
        get :index, params: { start_date: 2.days.ago.to_date, end_date: Time.current.to_date }

        expect(assigns(:lead_histories)).to match_array([lead_history1, lead_history2])
      end
    end

    context 'with search and date range filters' do
      it 'returns lead histories filtered by score name and sent_at date range' do
        get :index, params: { search: 'Maria', start_date: 2.days.ago.to_date, end_date: Time.current.to_date }

        expect(assigns(:lead_histories)).to match_array([lead_history1])
      end
    end
  end
end
