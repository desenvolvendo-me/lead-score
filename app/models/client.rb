# == Schema Information
#
# Table name: clients
#
#  id                   :bigint           not null, primary key
#  current_period_end   :datetime
#  current_period_start :datetime
#  document             :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  stripe_customer_id   :string
#  user_id              :bigint
#
# Indexes
#
#  index_clients_on_user_id  (user_id)
#
class Client < ApplicationRecord
  belongs_to :user

  def update_stripe_customer
    begin
      customer_name = [user.first_name, user.last_name].compact.join(' ').strip
      if stripe_customer_id.blank?
        customer = Stripe::Customer.create(email: user.email, name: customer_name)
        update(stripe_customer_id: customer.id)
      else
        customer = Stripe::Customer.update(stripe_customer_id, email: user.email, name: customer_name)
      end
    rescue Stripe::StripeError => e
      Rails.logger.error "Stripe error: #{e.message}"
      nil 
    end
    customer
  end
end
