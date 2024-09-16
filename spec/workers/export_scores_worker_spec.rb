require 'rails_helper'

RSpec.describe ExportScoresWorker, type: :worker do
  let(:user) { create(:user) }

  describe '#perform' do
    it 'exports scores, sends email with CSV file, and deletes the file' do
      create(:score, name: 'João', value: 100)
      create(:score, name: 'Alice', value: 80)

      mailer_double = double("Mailer")
      expect(UserMailer).to receive(:with).with(user: user, file_path: anything).and_return(mailer_double)
      expect(mailer_double).to receive(:send_scores_csv).and_return(mailer_double)
      expect(mailer_double).to receive(:deliver_later)

      ExportScoresWorker.new.perform(user.id)

      file_path = Rails.root.join("tmp", "scores-#{Date.today}.csv")
      expect(File.exist?(file_path)).to be(false)

      expect(Dir.glob(Rails.root.join("tmp", "scores-*.csv"))).to be_empty
    end
  end
end
