class ExportScoresJob
  include Sidekiq::Job

  def perform(user_email, file_path)
    return unless File.exist?(file_path)

    UserMailer.export_scores_csv(user_email: user_email, file_path: file_path).deliver_now
    File.delete(file_path)
  end
end
