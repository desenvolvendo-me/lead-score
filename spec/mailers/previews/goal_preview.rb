# Preview all emails at http://localhost:3000/rails/mailers/goal
class GoalPreview < ActionMailer::Preview
  def finished
    GoalMailer.finished
  end
end
