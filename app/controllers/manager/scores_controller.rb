module Manager
  class ScoresController < InternalController
    belongs_to :user

    before_action :set_ransack_params, only: [:index, :export]

    def index
      @q = Score.ransack(params[:q])
      @scores = @q.result.by_value(order_direction)
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

    def manual_send
      score_ids = params[:score_ids]
      destination = params[:destination]

      scores = Score.where(id: score_ids)

      begin
        scores.each do |score|
          SendLeadService.new(score, destination).call
        end
        redirect_to manager_scores_path, notice: I18n.t('manager.scores.manual_send.success')
      rescue StandardError => e
        redirect_to manager_scores_path, alert: I18n.t('manager.scores.manual_send.failure', error_message: e.message)
      end
    end

    private


    def order_direction
      params[:s] == 'value desc' ? :desc : :asc
    end

    def set_ransack_params
      @q = Score.ransack(ransack_params)
    end

    def ransack_params
      params.fetch(:q, {}).permit(:s, :name_cont, :value_eq, :value_gteq, :value_lteq)
    end

    def send_lead_to_webhook(score, destination)
      HTTParty.post(destination, {
        body: {
          name: score.name,
          value: score.value,
          data: score.data
        }.to_json,
        headers: { 'Content-Type' => 'application/json' }
      })
    end
  end
end
