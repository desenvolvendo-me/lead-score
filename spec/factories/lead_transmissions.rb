# == Schema Information
#
# Table name: lead_transmissions
#
#  id                  :bigint           not null, primary key
#  max_score_threshold :integer
#  min_score_threshold :integer
#  webhook_url         :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
FactoryBot.define do
  factory :lead_transmission do
    webhook_url { "MyString" }
    min_score_threshold { 1 }
    max_score_threshold { 1 }
  end
end
