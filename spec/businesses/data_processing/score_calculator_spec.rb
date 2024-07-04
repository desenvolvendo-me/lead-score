# spec/data_processing/json_loader_spec.rb

require 'rails_helper'

RSpec.describe DataProcessing::JsonLoader, type: :class do
  describe '.import_answers' do
    let(:json_answers) do
      {
        "Você já comprou algum curso de Programação?" => "Sim",
        "Você está em transição de carreira?" => "Sim",
      }
    end

    let(:json_weights) do
      {
        "Você já comprou algum curso de Programação?" => { "Sim" => 5, "Não" => 1 },
        "Você está em transição de carreira?" => { "Sim" => 4, "Não" => 2 },
      }
    end

    it 'processes the JSON answers and weights correctly' do
      result = described_class.import_answers(json_answers, json_weights)

      expected_answers = {
        "Você já comprou algum curso de Programação?" => "Sim",
        "Você está em transição de carreira?" => "Sim",
      }

      expected_weights = {
        "Você já comprou algum curso de Programação?" => 5,
        "Você está em transição de carreira?" => 4,
      }

      expect(result).to eq([expected_answers, expected_weights])
    end

    context 'with empty JSON for answers and weights' do
      let(:json_answers) { {} }
      let(:json_weights) { {} }

      it 'returns empty hashes for answers and weights' do
        result = described_class.import_answers(json_answers, json_weights)

        expected_answers = {}
        expected_weights = {}

        expect(result).to eq([expected_answers, expected_weights])
      end
    end
  end
end
