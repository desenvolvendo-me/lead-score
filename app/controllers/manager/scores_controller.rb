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
      scores = Score.all
      csv_data = Scoring::ScoreCsvExporter.generate(scores)

      file_path = Rails.root.join('tmp', "scores-#{Date.today}.csv")
      File.write(file_path, csv_data)

      ExportScoresJob.perform_async(current_user.id, file_path.to_s)

      send_data csv_data, filename: "scores-#{Date.today}.csv", type: 'text/csv', disposition: 'attachment'
    end

    def send_csv_email
      scores = Score.all
      csv_data = Scoring::ScoreCsvExporter.generate(scores)

      file_path = Rails.root.join('tmp', "scores-#{Date.today}.csv")
      File.write(file_path, csv_data)

      ExportScoresJob.perform_async(current_user.id, file_path.to_s)

      flash[:notice] = "Arquivo CSV enviado por e-mail com sucesso."
      redirect_to manager_scores_path
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
