require 'rails_helper'
require 'scoring/score_csv_exporter'

RSpec.describe Scoring::ScoreCsvExporter, type: :service do
  describe '.generate' do
    let(:scores) do
      [
        double('Score', name: 'Maria', value: 100),
        double('Score', name: 'Claudia', value: 95)
      ]
    end
    let(:csv_data) { Scoring::ScoreCsvExporter.generate(scores) }

    it 'generates CSV data with headers' do
      expect(csv_data).to include('Name,Score')
    end

    it 'includes the scores data' do
      expect(csv_data).to include('Maria,100')
      expect(csv_data).to include('Claudia,95')
    end
  end
end
