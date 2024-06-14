class StripeGateway
  def initialize
    Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)
  end

  def retrieve_recent_invoices(limit = 4)
    Stripe::Invoice.list(limit: limit).data
  rescue Stripe::StripeError => e
    Rails.logger.error("Stripe Error: #{e.message}")
    []
  end

  def retrieve_subscription(subscription_id)
    Stripe::Subscription.retrieve(subscription_id)
  rescue Stripe::StripeError => e
    Rails.logger.error("Stripe Error: #{e.message}")
    nil
  end

  def retrieve_plan_details(subscription)
    if subscription.items.data.any?
      plan = subscription.items.data.first.plan
      product = Stripe::Product.retrieve(plan.product)
      plan_name = product.name
      plan_interval = plan.interval
      plan_amount = plan.amount / 100.0  # Converte de centavos para unidades monetárias
      { name: plan_name, interval: plan_interval, amount: plan_amount }
    else
      { name: "Desconhecido", interval: "Desconhecido", amount: "Indisponível" }
    end
  rescue Stripe::StripeError => e
    Rails.logger.error("Stripe Error: #{e.message}")
    { name: "Erro ao recuperar o plano", interval: "Desconhecido", amount: "Indisponível" }
  end

  def create_checkout_session(user, plan_type, success_url, cancel_url)
    plan_id = get_plan_price_id(plan_type)
    Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
                     price: plan_id,
                     quantity: 1,
                   }],
      mode: 'subscription',  # ou 'payment', dependendo do seu caso
      success_url: success_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: cancel_url,
      metadata: {
        plan_name: plan_type,
        user_id: user.id
      }
    )
  rescue Stripe::StripeError => e
    Rails.logger.error("Stripe Error: #{e.message}")
    nil
  end

  def format_time(timestamp)
    Time.at(timestamp).strftime("%d de %B, %Y")
  rescue
    "Indisponível"
  end

  private

  def get_plan_price_id(plan_type)
    case plan_type
    when 'professional_montlhy'
      'price_1PCWsiRpXIS2OKDBowrOw4CT'
    when 'premium_montlhy'
      'price_1PCWuFRpXIS2OKDBlzlZvmWh'
    when 'professional_yearly'
      'price_1PCWwORpXIS2OKDB2Z7wcmWe'
    when 'premium_yearly'
      'price_1PCXVjRpXIS2OKDBRNodCpRx'
    else
      raise "Plano desconhecido: #{plan_type}"
    end
  end
end
