module Manager
  class ScoresController < InternalController
    belongs_to :user

    def index
      @scores = Score.all

    end
    def send_score
      @score = score.find(params[:id])
      destination = params[:destination]

      # Lógica de envio do lead
      # ...

      @score.register_send(destination)
      redirect_to scores_path, notice: 'Lead enviado com sucesso!'
    end
  end
end

