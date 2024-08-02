class LeadHistoriesController < ApplicationController
  def index
    @lead_histories = LeadHistory.includes(:score).order(sent_at: :desc)

    if params[:search].present?
      @lead_histories = @lead_histories.joins(:score).where('scores.name LIKE ?', "%#{params[:search]}%")
    end

    if params[:start_date].present? && params[:end_date].present?
      @lead_histories = @lead_histories.where(sent_at: params[:start_date]..params[:end_date])
    end
  end
  def register_send(destination)
    self.lead_histories.create(sent_at: Time.current, destination: destination)
  end
end
