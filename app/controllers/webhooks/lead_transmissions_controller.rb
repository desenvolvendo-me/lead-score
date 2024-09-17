module Webhooks
  class LeadTransmissionsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_lead_transmission, only: %i[show edit update destroy]

    def index
      @lead_transmissions = LeadTransmission.all
    end

    def show
    end

    def new
      @lead_transmission = LeadTransmission.new
    end

    def create
      @lead_transmission = LeadTransmission.new(lead_transmission_params)
      if @lead_transmission.save
        redirect_to webhooks_lead_transmissions_path, notice: I18n.t('lead_transmissions.destroy.success', default: 'Lead transmission was successfully destroyed.')
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @lead_transmission.update(lead_transmission_params)
        redirect_to webhooks_lead_transmissions_path, notice: I18n.t('lead_transmissions.update.success', default: 'Lead transmission was successfully updated.')
      else
        render :edit
      end
    end

    def destroy
      @lead_transmission.destroy
      redirect_to webhooks_lead_transmissions_path, notice: I18n.t('lead_transmissions.destroy.success', default: 'Lead transmission was successfully destroyed.')
    end

    private

    def lead_transmission_params
      params.require(:lead_transmission).permit(:webhook_url, :min_score_threshold, :max_score_threshold, :active)
    end

    def set_lead_transmission
      @lead_transmission = LeadTransmission.find(params[:id])
    end
  end
end