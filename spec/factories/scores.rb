# == Schema Information
#
# Table name: scores
#
#  id         :bigint           not null, primary key
#  name       :string
#  value      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :score do
    name { "Luisa" }
    value { 27 }
  end
end
