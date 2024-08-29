# == Schema Information
#
# Table name: survey_participations
#
#  id                   :bigint           not null, primary key
#  question_answer_pair :jsonb
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
FactoryBot.define do
  factory :survey_participation do
    question_answer_pair do
      {
        "first question": %w[Sim Não].sample,
        "second question": FFaker::Name.name,
        "third question": FFaker::Internet.email
      }.to_json
    end
  end
end
