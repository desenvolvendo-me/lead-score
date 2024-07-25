# == Schema Information
#
# Table name: lead_transmissions
#
#  id                  :bigint           not null, primary key
#  active              :boolean
#  max_score_threshold :integer
#  min_score_threshold :integer
#  webhook_url         :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
FactoryBot.define do
  factory :lead_transmission do
    webhook_url { "www.mywebhook.com" }
    min_score_threshold { 55 }
    max_score_threshold { 70 }
    active { true }
  end
end
