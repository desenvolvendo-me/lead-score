require 'rails_helper'

RSpec.describe LeadTransmission, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      lead_transmission = LeadTransmission.new(
        webhook_url: 'https://example.com/webhook',
        min_score_threshold: 90,
        max_score_threshold: 100,
        active: true
      )
      expect(lead_transmission).to be_valid
    end

    it 'is valid with a webhook_url' do
      lead_transmission = LeadTransmission.new(
        webhook_url: 'https://example.com/webhook'
      )
      expect(lead_transmission).to be_valid
    end

    it 'is not valid without a webhook_url' do
      lead_transmission = LeadTransmission.new(
        webhook_url: nil
      )
      expect(lead_transmission).not_to be_valid
      expect(lead_transmission.errors[:webhook_url]).to include("não pode ficar em branco")  
    end

    it 'is not valid with an invalid webhook_url' do
      lead_transmission = LeadTransmission.new(
        webhook_url: 'https://invinv.com.br/invalid',
        min_score_threshold: 90,
        max_score_threshold: 100,
        active: true
      )
      expect(lead_transmission.save).to be false
      expect(lead_transmission.errors[:webhook_url]).to include('is not valid')  
    end

    it 'is valid with a known good webhook_url' do
      lead_transmission = LeadTransmission.new(
        webhook_url: 'https://httpbin.org/post', 
        min_score_threshold: 90,
        max_score_threshold: 100,
        active: true
      )
      expect(lead_transmission).to be_valid
    end
  end
end
