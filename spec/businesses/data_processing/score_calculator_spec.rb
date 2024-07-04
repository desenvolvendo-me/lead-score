# spec/data_processing/score_calculator_spec.rb

require 'rails_helper'

RSpec.describe DataProcessing::ScoreCalculator, type: :class do
  describe '.calculate_score' do
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

    it 'calculates the total score correctly' do
      total_score = DataProcessing::ScoreCalculator.calculate_score(json_answers, json_weights)

      expected_score = 5 + 4

      expect(total_score).to eq(expected_score)
    end

    it 'calculates the score correctly with different answers' do
      json_answers = {
        "Você já comprou algum curso de Programação?" => "Não",
        "Você está em transição de carreira?" => "Não",
      }

      total_score = DataProcessing::ScoreCalculator.calculate_score(json_answers, json_weights)
      expected_score = 1 + 2

      expect(total_score).to eq(expected_score)
    end

    it 'calculates the score correctly with mixed answers' do
      json_answers = {
        "Você já comprou algum curso de Programação?" => "Sim",
        "Você está em transição de carreira?" => "Não",
      }

      total_score = DataProcessing::ScoreCalculator.calculate_score(json_answers, json_weights)
      expected_score = 5 + 2

      expect(total_score).to eq(expected_score)
    end


    it 'returns 0 for empty answers and weights' do
      json_answers = {}
      json_weights = {}

      total_score = DataProcessing::ScoreCalculator.calculate_score(json_answers, json_weights)

      expect(total_score).to eq(0)
    end
  end
end
