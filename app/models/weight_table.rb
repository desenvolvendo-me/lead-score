# == Schema Information
#
# Table name: weight_tables
#
#  id              :bigint           not null, primary key
#  description     :string
#  question_answer :jsonb            not null
#  status          :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class WeightTable < ApplicationRecord

  validates :question_answer, weight: true
end
