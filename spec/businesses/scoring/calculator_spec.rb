require 'rails_helper'

RSpec.describe Scoring::Calculator do
  describe '.calculate_score' do
    let(:weight) do
      instance_double(
        'Weight',
        description: 'Turma 21',
        status: 'active',
        question_answer: {
          'Você já comprou algum curso de Programação?' => { 'Sim' => 5, 'Não' => 1 },
          'Você está em transição de carreira?' => { 'Sim' => 4, 'Não' => 2 }
        }
      )
    end

    subject do
      described_class.calculate_score(
        survey_participation.question_answer_pair,
        weight.question_answer
      )
    end

    context 'when the answers to both questions are yes' do
      let(:survey_participation) do
        instance_double(
          'SurveyParticipation',
          question_answer_pair: {
            'Você já comprou algum curso de Programação?' => 'Sim',
            'Você está em transição de carreira?' => 'Sim'
          }
        )
      end

      it 'calculates the total score correctly' do
        expect(subject).to eq(9)
      end
    end

    context 'when the answer to the first weights question is yes and the second is no' do
      let(:survey_participation) do
        instance_double(
          'SurveyParticipation',
          question_answer_pair: {
            'Você já comprou algum curso de Programação?' => 'Sim',
            'Você está em transição de carreira?' => 'Não'
          }
        )
      end

      it 'calculates the total score correctly' do
        expect(subject).to eq(7)
      end
    end
  end
end
