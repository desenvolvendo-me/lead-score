# app/validators/weight_validator.rb
class WeightValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.is_a?(Hash)
      value.each do |question, answers|
        if question.blank?
          record.errors.add(attribute, "contains a question with a blank key")
        end

        if answers.is_a?(Hash)
          answers.each do |answer, weight|
            if answer.blank?
              record.errors.add(attribute, "contains an answer with a blank key")
            end
            if weight.blank?
              record.errors.add(attribute, "contains an answer with a blank value")
            end
          end
        else
          record.errors.add(attribute, "contains a non-hash value for a question")
        end
      end
    else
      record.errors.add(attribute, "is not a hash")
    end
  end
end