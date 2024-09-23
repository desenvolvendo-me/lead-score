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

      send_data csv_data, filename: "scores-#{Date.today}.csv", type: 'text/csv', disposition: 'attachment'
    end

    def send_csv_email
      scores = Score.all
      csv_data = Scoring::ScoreCsvExporter.generate(scores)

      # Salva o CSV em um arquivo temporário
      file_path = Rails.root.join('tmp', "scores-#{Date.today}.csv")
      File.write(file_path, csv_data)

      # Chama o job para processar o envio do email de forma assíncrona
      ExportScoresJob.perform_async(current_user.email, file_path.to_s)

      redirect_to manager_scores_path, notice: "O CSV está sendo enviado por e-mail."
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
