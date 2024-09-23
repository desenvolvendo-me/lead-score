class ExportScoresJob
  include Sidekiq::Job

  def perform(user_id, file_path)
    user = User.find(user_id)
    UserMailer.with(user: user, file_path: file_path).send_scores_csv.deliver_now
    File.delete(file_path) if File.exist?(file_path)
  end
end
