class WeightTable < ApplicationRecord
  validate :validate_question_answer_structure

  private

  def validate_question_answer_structure
    unless WeightValidator.valid_structure?(question_answer.to_json)
      errors.add(:question_answer, "has an invalid structure")
    end
  end
end
