# == Schema Information
#
# Table name: survey_participations
#
#  id                   :bigint           not null, primary key
#  question_answer_pair :jsonb
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
class SurveyParticipation < ApplicationRecord
  validates :question_answer_pair, presence: true
end
