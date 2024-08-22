class JsonSchemaValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.is_a?(Hash)
      record.errors.add(attribute, :blank)
      return
    end

    value.each do |question, answer|
      record.errors.add(attribute, :blank) if question.blank? || answer.blank?
    end
  end
end
