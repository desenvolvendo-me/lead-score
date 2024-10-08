class WeightsController < ApplicationController
  before_action :set_weight, only: [:show, :edit, :update, :destroy]

  def index
    @weights = Weight.all
  end

  def show
  end

  def new
    @weight = Weight.new
  end

  def edit
  end

  def create
    @weight = Weight.new(weight_params)
    respond_to do |format|
      if @weight.save
        format.html { redirect_to @weight, notice: I18n.t('notice.create', model:'Weight')}
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @weight.update(weight_params)
        format.html { redirect_to @weight, notice: I18n.t('notice.update', model:'Weight')}
      else
        format.html { render :edit, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @weight.destroy
    respond_to do |format|
      format.html { redirect_to weights_url, notice: I18n.t('notice.destroy', model:'Weight')}
    end
  end

  private

  def set_weight
    @weight = Weight.find(params[:id])
  end

  def weight_params
    params.require(:weight).permit(:description, :status, :question_answer)
  end
end
