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
  validate :validate_question_answer_structure

  private

  def validate_question_answer_structure
    unless WeightValidator.valid_structure?(question_answer.to_json)
      errors.add(:question_answer, "has an invalid structure")
    end
  end
end
