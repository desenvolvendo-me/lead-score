require 'rails_helper'

RSpec.describe SurveyParticipations::Saver do
  let(:survey) do
    [
      {
        '0' => 'Carimbo de data/hora',
        '1' => 'Além deste, você já comprou outro curso de Programação?',
        '2' => 'Qual o seu nome?',
        '3' => 'Qual seu E-mail?'
      },
      {
        '0' => '06/07/2024 21:38:50',
        '1' => 'Sim',
        '2' => 'Edinardo',
        '3' => 'edinardobezerra@yahoo.com.br'
      },
      {
        '0' => '08/07/2024 10:52:59',
        '1' => 'Sim',
        '2' => 'Thales Henrique Cardoso',
        '3' => 'thales.milion25@gmail.com'
      },
      {
        '0' => '08/07/2024 10:52:59',
        '1' => 'Sim',
        '2' => 'Roberto Figueiredo',
        '3' => 'rb.f53@gmail.com'
      }
    ]
  end

  let(:invalid_data) do
    {}
  end

  describe '.call' do
    context 'when data is valid' do
      it 'creates a survey participation and increases the count' do
        expect do
          described_class.call(survey)
        end.to change { SurveyParticipation.count }.by(3)
      end
    end

    context 'when the data is invalid' do
      it 'do not creates a survey and increases the Survey count' do
        expect do
          described_class.call(invalid_data)
        end.to change { SurveyParticipation.count }.by(0)
      end
    end
  end
end
