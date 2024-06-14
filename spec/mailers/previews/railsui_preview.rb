# Preview all emails at http://localhost:3000/rails/mailers/railsui
class RailsuiPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/railsui/minimal
  def minimal
    RailsuiMailer.minimal
  end

  # Preview this email at http://localhost:3000/rails/mailers/railsui/promotion
  def promotion
    RailsuiMailer.promotion
  end

  # Preview this email at http://localhost:3000/rails/mailers/railsui/transactional
  def transactional
    RailsuiMailer.transactional
  end
end
