class UserMailer < ApplicationMailer
  def export_scores_csv(user_email:, file_path:)
    attachments["scores-#{Date.today}.csv"] = File.read(file_path)
    mail(to: user_email, subject: 'Exportação de Scores')
  end
end
