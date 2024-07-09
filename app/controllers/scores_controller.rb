class ScoresController < ApplicationController
  before_action :set_score, only: [:show, :edit, :update, :destroy]
  def index
    render 'manager/scores/index'
  end

  def show
    @score = Score.find(params[:id])
    render :show
  end
end

  private
# Use callbacks to share common setup or constraints between actions.
  def set_score
    @score = Score.find(params[:id])
end

# Only allow a list of trusted parameters through.
  def score_params
    params.require(:score).permit(:name, :value)
end
