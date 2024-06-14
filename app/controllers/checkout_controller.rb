
require_relative './../businesses/gateways/stripe_gateway'
class CheckoutController < ApplicationController
  before_action :set_stripe_gateway

  def create
    user = current_user
    plan_type = params[:plan]

    session = @stripe_gateway.create_checkout_session(
      user,
      plan_type,
      checkout_success_url,
      checkout_cancel_url
    )

    if session
      redirect_to session.url, allow_other_host: true
    else
      flash[:error] = "Houve um problema ao criar a sessão de checkout."
      redirect_to pricing_path
    end
  end

  def success
    render 'checkout/success'
  end

  def cancel
    render 'checkout/cancel'
  end

  private

  def set_stripe_gateway
    @stripe_gateway = StripeGateway.new
  end
end
