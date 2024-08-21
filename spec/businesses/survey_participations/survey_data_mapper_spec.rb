# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SurveyParticipations::SurveyDataMapper do
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
      }
    ]
  end

  let(:expected_json) do
    [
      {
        'Além deste, você já comprou outro curso de Programação?' => 'Sim',
        'Qual o seu nome?' => 'Edinardo',
        'Qual seu E-mail?' => 'edinardobezerra@yahoo.com.br'
      },
      {
        'Além deste, você já comprou outro curso de Programação?' => 'Sim',
        'Qual o seu nome?' => 'Thales Henrique Cardoso',
        'Qual seu E-mail?' => 'thales.milion25@gmail.com'
      }
    ]
  end

  describe '.call' do
    context 'when survey is valid' do
      subject { described_class.call(survey) }

      it 'maps the survey to questions and answers' do

        expect(subject).to eq(expected_json)
      end
    end
  end
end
