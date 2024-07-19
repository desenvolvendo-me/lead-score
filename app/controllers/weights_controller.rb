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

    Rails.logger.debug("Received params: #{params[:weight][:question_answer]}")

    if @weight.question_answer.is_a?(String)
      @weight.question_answer = JSON.parse(@weight.question_answer)
    end

    respond_to do |format|
      if @weight.save
        format.html { redirect_to @weight, notice: 'Weight was successfully created.' }
        format.json { render :show, status: :created, location: @weight }
      else
        format.html { render :new }
        format.json { render json: @weight.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @weight.update(weight_params)
        format.html { redirect_to @weight, notice: 'Weight was successfully updated.'}
        format.json { render :show, status: :ok, location: @weight }
      else
        format.html { render :edit }
        format.json { render json: @weight.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @weight.destroy
    respond_to do |format|
      format.html { redirect_to weights_url, notice: 'Weight was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_weight
    @weight = Weight.find(params[:id])
  end

  def weight_params
    params.require(:weight).permit(:description, :status, question_answer: {})
  end

end
