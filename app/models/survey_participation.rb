# == Schema Information
#
# Table name: survey_participations
#
#  id                    :bigint           not null, primary key
#  consistency_status    :string
#  inconsistency_details :jsonb
#  question_answer_pair  :jsonb
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
class SurveyParticipation < ApplicationRecord
  validates :question_answer_pair, presence: true
  validates :question_answer_pair, non_empty_json: true

  before_create :check_consistency

  enum consistency_status: {
    consistent: 'consistent',
    inconsistent: 'inconsistent',
    pending: 'pending'
  }

  private

  def check_consistency
    self.inconsistency_details = []

    question_answer_pair.each do |question, answer|
      if question.blank?
        add_inconsistency('The question is blank')
      elsif answer.blank?
        add_inconsistency('The answer is blank')
      else
        weight = Weight.find_by("question_answer ? :key", key: question)

        if weight.nil?
          add_inconsistency('The question was not found')
        elsif !weight.question_answer[question].key?(answer)
          add_inconsistency('The answer was not found')
        end
      end
    end

    self.consistency_status = inconsistency_details.empty? ? :consistent : :inconsistent
  end

  def add_inconsistency(message)
    return if inconsistency_details.include?(message)

    inconsistency_details << message
  end
end
