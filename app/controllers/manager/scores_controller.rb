module Manager
  class ScoresController < InternalController
    belongs_to :user

    def index
      @order = params[:order]
      @scores = if @order == 'asc'
                  Score.order(value: :asc)
                elsif @order == 'desc'
                  Score.order(value: :desc)
                else
                  Score.all
                end
    end
  end
end
