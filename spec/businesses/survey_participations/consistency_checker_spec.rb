# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SurveyParticipations::ConsistencyChecker do
  before do
    create(:weight,
           question_answer: {
             'In addition to this, have you already purchased another Programming course?' => {
               'Yes' => 10, 'Not' => 5
             }
           })
  end

  let(:survey_participation) do
    build(:survey_participation, question_answer_pair: question_answer_pair)
  end

  subject { described_class.new(survey_participation) }

  describe '#call' do
    before { subject.call }

    context 'when question is blank' do
      let(:question_answer_pair) { { '' => 'Yes' } }

      it 'adds an inconsistency for the blank question' do
        expect(survey_participation.inconsistency_details)
          .to include("The question: '', was not found")
        expect(survey_participation.consistency_status).to eq('inconsistent')
      end
    end

    context 'when question is not found' do
      let(:question_answer_pair) { { 'Nonexistent question' => 'Yes' } }

      it 'adds an inconsistency for the not found question' do
        expect(survey_participation.inconsistency_details).to include(
          "The question: 'Nonexistent question', was not found"
        )
        expect(survey_participation.consistency_status).to eq('inconsistent')
      end
    end

    context 'when answer is not found for an existing question' do
      let(:question_answer_pair) do
        { 'In addition to this, have you already purchased another Programming course?' => 'Nonexistent answer' }
      end

      it 'adds an inconsistency for the not found answer' do
        expect(survey_participation.inconsistency_details).to include(
                                                                "The answer: 'Nonexistent answer' to the In addition to this, have you already purchased another Programming course? question, was not found"
                                                              )
        expect(survey_participation.consistency_status).to eq('inconsistent')
      end
    end

    context 'when answer is blank for an existing question' do
      let(:question_answer_pair) do
        { 'In addition to this, have you already purchased another Programming course?' => '' }
      end

      it 'adds an inconsistency for the not found answer' do
        expect(survey_participation.inconsistency_details).to include(
          "The answer: '' to the In addition to this, have you already purchased another Programming course? question, was not found"
        )
        expect(survey_participation.consistency_status).to eq('inconsistent')
      end
    end

    context 'when all questions and answers are valid' do
      let(:question_answer_pair) do
        {
          'In addition to this, have you already purchased another Programming course?' => 'Yes'
        }
      end

      it 'does not add any inconsistencies' do
        expect(survey_participation.inconsistency_details).to be_empty
        expect(survey_participation.consistency_status).to eq('consistent')
      end
    end
  end
end
