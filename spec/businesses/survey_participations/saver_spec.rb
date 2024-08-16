require 'rails_helper'

RSpec.describe SurveyParticipations::Saver do
  let(:valid_data) do
    {
      'Além deste, você já comprou outro curso de Programação?' => 'Sim',
      'Qual o seu nome?' => 'Thales Henrique Cardoso',
      'Qual seu E-mail?' => 'thales.milion25@gmail.com'
    }
  end

  let(:invalid_data) do
    {}
  end

  describe '.call' do
    context 'when data is valid' do
      it 'creates a survey participation and increases the count' do
        expect do
          described_class.call(valid_data)
        end.to change { SurveyParticipation.count }.by(1)
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
