require 'rails_helper'

RSpec.describe ExportScoresJob, type: :job do
  let(:user) { create(:user) }
  let(:file_path) { Rails.root.join('tmp', "scores-#{Date.today}.csv") }

  before do
    allow(Scoring::ScoreCsvExporter).to receive(:generate).and_return("csv_content")
  end

  describe '#perform' do
    it 'encontra o usuário pelo id' do
      expect(User).to receive(:find).with(user.id).and_return(user)
      described_class.new.perform(user.id)
    end

    it 'gera o CSV com os scores' do
      expect(Scoring::ScoreCsvExporter).to receive(:generate).with(Score.all)
      described_class.new.perform(user.id)
    end

    it 'envia o email com o arquivo CSV anexado' do
      allow(File).to receive(:write).with(file_path, "csv_content")
      allow(File).to receive(:read).with(file_path).and_return("csv_content")

      mailer_double = double('UserMailer')
      expect(UserMailer).to receive(:with).with(user: user, file_path: file_path).and_return(mailer_double)
      expect(mailer_double).to receive(:send_scores_csv).and_return(mailer_double)
      expect(mailer_double).to receive(:deliver_now)
      described_class.new.perform(user.id)
    end

    it 'deleta o arquivo CSV após o envio do email' do
      allow(File).to receive(:delete).with(file_path)
      described_class.new.perform(user.id)
      expect(File).to have_received(:delete).with(file_path)
    end
  end

end
