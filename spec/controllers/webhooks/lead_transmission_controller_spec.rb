require 'rails_helper'

RSpec.describe Webhooks::LeadTransmissionsController, type: :controller do
  let(:user) { create(:user) }  # Supondo que você tenha um factory para user
  let(:valid_attributes) { { webhook_url: 'http://example.com', min_score_threshold: 10, max_score_threshold: 100 } }
  let(:invalid_attributes) { { webhook_url: '', min_score_threshold: nil, max_score_threshold: nil } }
  let(:lead_transmission) { create(:lead_transmission) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: lead_transmission.to_param }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new LeadTransmission' do
        expect {
          post :create, params: { lead_transmission: valid_attributes }
        }.to change(LeadTransmission, :count).by(1)
      end

      it 'redirects to the lead transmissions list' do
        post :create, params: { lead_transmission: valid_attributes }
        expect(response).to redirect_to(webhooks_lead_transmissions_path)
      end
    end

    context 'with invalid params' do
      it 'returns a success response (i.e. to display the "new" template)' do
        post :create, params: { lead_transmission: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { id: lead_transmission.to_param }
      expect(response).to be_successful
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { webhook_url: 'http://newexample.com', min_score_threshold: 20, max_score_threshold: 90 } }

      it 'updates the requested lead transmission' do
        put :update, params: { id: lead_transmission.to_param, lead_transmission: new_attributes }
        lead_transmission.reload
        expect(lead_transmission.webhook_url).to eq('http://newexample.com')
      end

      it 'redirects to the lead transmissions list' do
        put :update, params: { id: lead_transmission.to_param, lead_transmission: new_attributes }
        expect(response).to redirect_to(webhooks_lead_transmissions_path)
      end
    end

    context 'with invalid params' do
      it 'returns a success response (i.e. to display the "edit" template)' do
        put :update, params: { id: lead_transmission.to_param, lead_transmission: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested lead transmission' do
      lead_transmission
      expect {
        delete :destroy, params: { id: lead_transmission.to_param }
      }.to change(LeadTransmission, :count).by(-1)
    end

    it 'redirects to the lead transmissions list' do
      delete :destroy, params: { id: lead_transmission.to_param }
      expect(response).to redirect_to(webhooks_lead_transmissions_path)
    end
  end
end
