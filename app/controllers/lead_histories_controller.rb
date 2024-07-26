
class LeadHistoriesController < ApplicationController
  def index
    @lead_histories = LeadHistory.order(sent_at: :desc)

    if params[:search].present?
      @lead_histories = @lead_histories.where('lead LIKE ?', "%#{params[:search]}%")
    end

    if params[:start_date].present? && params[:end_date].present?
      @lead_histories = @lead_histories.where(sent_at: params[:start_date]..params[:end_date])
    end
  end
end
