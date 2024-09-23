class ExportScoresWorker
  include Sidekiq::Worker

  def perform(user_id, file_path)
    user = User.find(user_id)

    # Envia o e-mail com o CSV gerado
    UserMailer.with(user: user, file_path: file_path).send_scores_csv.deliver_now

    # Remove o arquivo temporário após o envio
    File.delete(file_path) if File.exist?(file_path)
  end
end
