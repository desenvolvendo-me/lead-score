# == Schema Information
#
# Table name: weights
#
#  id              :bigint           not null, primary key
#  description     :string
#  question_answer :jsonb            not null
#  status          :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Weight < ApplicationRecord
  validates :description, presence: true
  validates :question_answer, presence: true, weight: true
end
