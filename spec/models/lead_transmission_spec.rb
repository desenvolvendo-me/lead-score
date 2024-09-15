# == Schema Information
#
# Table name: lead_transmissions
#
#  id                  :bigint           not null, primary key
#  active              :boolean
#  max_score_threshold :integer
#  min_score_threshold :integer
#  webhook_url         :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
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
    end
  end
end
