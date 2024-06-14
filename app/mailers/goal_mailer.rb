class GoalMailer < ApplicationMailer
  def finished
    @user = params[:user]
    @variable = 'exemplo'
    mail(to: 'user@email.com', subject: t('.subject'))
  end
end
