class ExportScoresWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find(user_id)
    scores = Score.all

    csv_data = generate_csv(scores)

    file_path = Rails.root.join("tmp", "scores-#{Date.today}.csv")
    File.write(file_path, csv_data)

    UserMailer.with(user: user, file_path: file_path).send_scores_csv.deliver_now

    File.delete(file_path) if File.exist?(file_path)
  end

  private

  def generate_csv(scores)
    CSV.generate(headers: true) do |csv|
      csv << ["ID", "Nome", "Valor", "Data"]

      scores.each do |score|
        csv << [score.id, score.name, score.value, score.data.to_json]
      end
    end
  end
end
