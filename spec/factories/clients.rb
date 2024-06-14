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
FactoryBot.define do
  factory :client do
    document { FFaker::IdentificationBR.pretty_cpf }
    association :user, factory: :user
  end
end
