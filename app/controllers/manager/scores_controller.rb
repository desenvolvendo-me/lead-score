module Manager
  class ScoresController < InternalController
    belongs_to :user

    def index
      @q = Score.ransack(params[:q])
      @scores = @q.result
    end
  end
end