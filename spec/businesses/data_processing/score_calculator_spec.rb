# spec/models/data_processing/score_calculator_spec.rb
require 'rails_helper'

RSpec.describe DataProcessing::ScoreCalculator, type: :class do
  describe '.calculate_score' do
    let!(:answer_table) { create(:answer_table) }

    it 'calculates the total score correctly' do
      allow(WeightTable).to receive(:take).and_return(
        double(question_answer:
          {
            "Você já comprou algum curso de Programação?" => { "Sim" => 5, "Não" => 1 },
            "Você está em transição de carreira?" => { "Sim" => 4, "Não" => 2 }
          }
        )
      )

      total_score = DataProcessing::ScoreCalculator.calculate_score
      expected_score = 5 + 4
      expect(total_score).to eq(expected_score)
    end

    it 'calculates the total score correctly' do
      allow(WeightTable).to receive(:take).and_return(
        double(question_answer:
          {
            "Você já comprou algum curso de Programação?" => { "Sim" => 6, "Não" => 2 },
            "Você está em transição de carreira?" => { "Sim" => 3, "Não" => 1 }
          }
        )
      )

      total_score = DataProcessing::ScoreCalculator.calculate_score
      expected_score = 6 + 3
      expect(total_score).to eq(expected_score)
    end
  end
end
