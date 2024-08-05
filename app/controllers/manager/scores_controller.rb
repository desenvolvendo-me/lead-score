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

    def manual_send
      score_ids = params[:score_ids]
      destination = params[:destination]

      scores = Score.where(id: score_ids)

      begin
        scores.each do |score|
          response = send_lead_to_webhook(score, destination)
          if response.success?
            score.register_send(destination)
          else
            # Trate o erro conforme necessário, por exemplo, armazenando a falha no banco de dados
            Rails.logger.error "Falha ao enviar lead #{score.id} para #{destination}: #{response.body}"
          end
        end
        redirect_to manager_scores_path, notice: 'Leads enviados com sucesso!'
      rescue StandardError => e
        redirect_to manager_scores_path, alert: "Falha ao enviar leads: #{e.message}"
      end
    end

    private

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
