class UserMailer < ApplicationMailer
  def send_scores_csv
    @user = params[:user]
    file_path = params[:file_path]

    attachments["scores-#{Date.today}.csv"] = File.read(file_path)
    mail(to: @user.email, subject: 'Exportação de Scores')
  end
end
