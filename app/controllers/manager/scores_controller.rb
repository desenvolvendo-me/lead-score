require 'csv'

module Manager
  class ScoresController < InternalController
    belongs_to :user

    before_action :set_ransack_params, only: [:index, :export]

    def index
      @q = Score.ransack(params[:q])
      order = params[:s] == 'value desc' ? { value: :desc } : { value: :asc }
      @scores = @q.result.order(order)
    end

    def export
      @scores = @q.result

      csv_data = CSV.generate(headers: true) do |csv|
        csv << ['Name', 'Score']
        @scores.each do |score|
          csv << [score.name, score.value]
        end
      end

      send_data csv_data, filename: "scores-#{Date.today}.csv", type: 'text/csv; charset=utf-8'
    end

    private

    def set_ransack_params
      @q = Score.ransack(ransack_params)
    end

    def ransack_params
      params.fetch(:q, {}).permit(:s, :name_cont, :value_eq, :value_gteq, :value_lteq)
    end
  end
end
