require 'csv'

module Manager
  class ScoresController < InternalController
    belongs_to :user

    def index
      @q = Score.ransack(params[:q])
      @scores = @q.result
    end

    def export
      @q = Score.ransack(params[:q])
      @scores = @q.result

      csv_data = CSV.generate(headers: true) do |csv|
        csv << ['Name', 'Score']
        @scores.each do |score|
          csv << [score.name, score.value]
        end
      end

      send_data csv_data, filename: "scores-#{Date.today}.csv", type: 'text/csv'
    end
  end
end
