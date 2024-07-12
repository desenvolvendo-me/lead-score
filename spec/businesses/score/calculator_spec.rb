# spec/models/score/calculator_spec.rb
require 'rails_helper'

RSpec.describe Score::Calculator do
  describe '.calculate_score' do
    let(:answer_instance) { create(:answer) }
    let(:weight_instance) { create(:weight) }

    it 'calculates the total score correctly' do
      lead_answers = answer_instance.question_answer
      json_answers = lead_answers["answers"]
      json_weights = weight_instance.question_answer

      total_score = Score::Calculator.calculate_score(json_answers, json_weights)

      expected_score = 5 + 4 # Valor esperado baseado nos pesos fornecidos
      expect(total_score).to eq(expected_score)
    end

    it 'calculates the total score correctly with different JSON data' do
      # Alterando o JSON do answer_instance para outro cenário
      answer_instance.update(question_answer: {
        lead: {
          name: "Alice",
          email: "alice@example.com",
          telefone: "987654321"
        },
        answers: {
          "Você já comprou algum curso de Programação?" => "Sim",
          "Você está em transição de carreira?" => "Não"
        }
      })

      lead_answers = answer_instance.question_answer
      json_answers = lead_answers["answers"]
      json_weights = weight_instance.question_answer

      total_score = Score::Calculator.calculate_score(json_answers, json_weights)

      # Calculando o score esperado com base nos novos valores do JSON
      expected_score = 5 + 2 # Supondo os pesos modificados no JSON de weight_table_instance
      expect(total_score).to eq(expected_score)
    end
  end
end
