module Manager
  class ScoresController < InternalController
    belongs_to :user

    def index
      @scores = Score.all

    end
  end
end

