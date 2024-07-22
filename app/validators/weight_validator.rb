class WeightValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    begin
      value = JSON.parse(value) if value.is_a?(String) && value.present?
    rescue JSON::ParserError
      record.errors.add(attribute, I18n.t("errors.messages.not_a_json"))
      return
    end

    unless value.is_a?(Hash)
      record.errors.add(attribute, I18n.t("errors.messages.not_a_hash"))
      return
    end

    value.each do |question, answers|
      if question.blank?
        record.errors.add(attribute, I18n.t("errors.messages.blank_question_key"))
      end

      unless answers.is_a?(Hash)
        record.errors.add(attribute, I18n.t("errors.messages.not_a_hash_question_value"))
        next
      end

      answers.each do |answer, weight|
        if answer.blank?
          record.errors.add(attribute, I18n.t("errors.messages.blank_answer_key"))
        end
        if weight.blank?
          record.errors.add(attribute, I18n.t("errors.messages.not_a_hash_answer_value"))
        end
      end
    end
  end
end
