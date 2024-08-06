class AnswerValidator < ActiveModel::Validator
  def validate(record)
    json_data = record.question_answer

    # Verifica se json_data é um Hash
    unless json_data.is_a?(Hash)
      record.errors.add(:question_answer, "Invalid JSON format.")
      return
    end

    json_data.each do |key, value|
      if value.is_a?(Hash)
        value.each do |sub_key, sub_value|
          unless sub_value.is_a?(String)
            record.errors.add(:question_answer, "For the key '#{sub_key}', the value must be a string.")
          end
        end
      elsif !value.is_a?(String)
        record.errors.add(:question_answer, "For the key '#{key}', the value must be a string.")
      end
    end
  end
end
