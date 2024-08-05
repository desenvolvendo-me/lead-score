require 'rails_helper'

RSpec.describe LeadHistory, type: :model do
  let(:score) { create(:score) }
  let(:lead_history) { build(:lead_history, score: score) }

  describe 'associations' do
    it { should belong_to(:score) }
  end

  describe 'validations' do
    it { should validate_presence_of(:score) }
    it { should validate_presence_of(:sent_at) }
    it { should validate_presence_of(:destination) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(lead_history).to be_valid
    end
  end
end
