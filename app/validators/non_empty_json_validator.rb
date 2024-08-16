# frozen_string_literal: true

class NonEmptyJsonValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return unless value.is_a?(Hash) && value.empty?

    record.errors.add(attribute, "can't be empty")
  end
end

