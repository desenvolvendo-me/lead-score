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
#  score_id    :bigint           not null
#
# Indexes
#
#  index_lead_histories_on_score_id  (score_id)
#
# Foreign Keys
#
#  fk_rails_...  (score_id => scores.id)
#
FactoryBot.define do
  factory :lead_history do
    sent_at { Time.current }
    destination { "Destino" }
    association :score
  end
end
