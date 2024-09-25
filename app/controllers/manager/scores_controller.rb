require 'csv'

module Manager
  class ScoresController < InternalController
    before_action :set_ransack_params, only: [:index, :export]

    def index
      @q = Score.ransack(params[:q])
      order = params[:s] == 'value desc' ? { value: :desc } : { value: :asc }
      @scores = @q.result.order(order)
    end

    def export
      ExportScoresJob.perform_async(current_user.id)

      scores = Score.all
      csv_data = Scoring::ScoreCsvExporter.generate(scores)

      send_data csv_data, filename: "scores-#{Date.today}.csv", type: 'text/csv', disposition: 'attachment'
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
