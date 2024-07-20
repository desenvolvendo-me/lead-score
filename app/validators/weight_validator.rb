class WeightValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    begin
      value = JSON.parse(value) if value.is_a?(String) && value.present?
    rescue JSON::ParserError
      record.errors.add(attribute, I18n.t("is not a valid JSON string"))
      return
    end

    unless value.is_a?(Hash)
      record.errors.add(attribute, I18n.t("is not a hash"))
      return
    end

    value.each do |question, answers|
      if question.blank?
        record.errors.add(attribute, I18n.t("contains a question with a blank key"))
      end

      unless answers.is_a?(Hash)
        record.errors.add(attribute, I18n.t("contains a non-hash value for a question"))
        next
      end

      answers.each do |answer, weight|
        if answer.blank?
          record.errors.add(attribute, I18n.t("contains an answer with a blank key"))
        end
        if weight.blank?
          record.errors.add(attribute, I18n.t("contains an answer with a blank value"))
        end
      end
    end
  end
end
