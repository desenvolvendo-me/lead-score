# == Schema Information
#
# Table name: survey_participations
#
#  id                   :bigint           not null, primary key
#  question_answer_pair :jsonb
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
require 'rails_helper'

RSpec.describe SurveyParticipation, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:question_answer_pair) }
  end

  context 'when question_answer_pair is empty' do
    let(:empty_question_answer_pair) do
      described_class.new(question_answer_pair: {})
    end

    it 'is not valid' do
      expect(empty_question_answer_pair).not_to be_valid
      expect(empty_question_answer_pair.errors[:question_answer_pair])
        .to include("can't be empty")
    end
  end

  context 'when question_answer_pair is non-empty' do
    let(:valid_question_answer_pair) do
      described_class.new(question_answer_pair: { 'key' => 'value' })
    end
    it 'is valid' do
      expect(valid_question_answer_pair).to be_valid
    end
  end
end
