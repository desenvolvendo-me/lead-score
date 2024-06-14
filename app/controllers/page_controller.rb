require_relative '././../businesses/gateways/stripe_gateway'
class PageController < ApplicationController
  before_action :set_stripe_gateway
  before_action :set_recent_invoices, only: [:billing]

  def activity
    render layout: 'admin'
  end

  def profile
    render layout: 'admin'
  end

  def people
    render layout: 'admin'
  end

  def calendar
    render layout: 'admin'
  end

  def assignments
    render layout: 'admin'
  end

  def message
    render layout: 'admin'
  end

  def messages
    render layout: 'admin'
  end

  def project
    render layout: 'admin'
  end

  def projects
    render layout: 'admin'
  end

  def dashboard
    render layout: 'admin'
  end

  def homepage; end

  def about; end

  def pricing; end

  def faq; end

  def billing
    if @recent_invoices.any?
      first_invoice = @recent_invoices.first
      subscription_id = first_invoice.subscription

      if subscription_id.present?
        subscription = @stripe_gateway.retrieve_subscription(subscription_id)
        plan_details = @stripe_gateway.retrieve_plan_details(subscription)
        @plan_name = plan_details[:name]
        @plan_interval = plan_details[:interval]
        @plan_amount = plan_details[:amount]
        @plan_currency = subscription.currency.upcase
        @current_period_end = @stripe_gateway.format_time(subscription.current_period_end)
      else
        set_default_plan_details
      end
    else
      set_default_plan_details
    end
    render layout: 'admin'
  end

  def integrations; end

  def team; end

  def notifications; end

  def settings; end

  private

  def set_stripe_gateway
    @stripe_gateway = StripeGateway.new
  end

  def set_recent_invoices
    @recent_invoices = @stripe_gateway.retrieve_recent_invoices
  end

  def set_default_plan_details
    @plan_name = "Não disponível"
    @plan_currency = "USD"
    @plan_amount = "Indisponível"
    @current_period_end = "Indisponível"
    @plan_interval = "Desconhecido"
  end
end
