# == Schema Information
#
# Table name: scores
#
#  id                :bigint           not null, primary key
#  auto_send_enabled :boolean          default(TRUE)
#  name              :string
#  score_threshold   :integer          default(0)
#  value             :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
FactoryBot.define do
  factory :score do
    name { "Luisa" }
    value { 27 }
  end
end
