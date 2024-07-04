class ScoresController < ApplicationController
    def index
      render 'manager/scores/index'
    end


    def show
      @score = Score.find(params[:id])
      render :show
    end
end