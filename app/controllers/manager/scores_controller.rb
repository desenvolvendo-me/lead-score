module Manager
  class ScoresController < InternalController

    def index
      @scores = Score.all
    end

  end
end