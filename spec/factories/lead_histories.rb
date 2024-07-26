# == Schema Information
#
# Table name: lead_histories
#
#  id          :bigint           not null, primary key
#  destination :string
#  lead        :string
#  sent_at     :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :lead_history do
    sent_at { "2024-07-26 10:36:32" }
    destination { "Destino" }
    lead { nil }
  end
end
