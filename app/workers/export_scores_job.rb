class ExportScoresJob
  include Sidekiq::Job

  def perform(user_id)
    user = User.find(user_id)

    scores = Score.all
    csv_data = Scoring::ScoreCsvExporter.generate(scores)

    file_path = Rails.root.join('tmp', "scores-#{Date.today}.csv")
    File.write(file_path, csv_data)

    UserMailer.with(user: user, file_path: file_path).send_scores_csv.deliver_now
    File.delete(file_path) if File.exist?(file_path)
  end
end
