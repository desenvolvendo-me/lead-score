# app/validators/custom_validator.rb
class WeightValidator < ActiveModel::Validator
  def validate(record)
    #TODO: Escrever aqui a regra de validação do json
    # if record.question_answer.blank?
    #   record.errors.add(:question_answer, "is invalid")
    # end
  end
end
