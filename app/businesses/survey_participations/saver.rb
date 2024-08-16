# frozen_string_literal: true

module SurveyParticipations
  class Saver < BusinessApplication
    def initialize(question_answer_pair)
      @question_answer_pair = question_answer_pair
    end

    def call
      SurveyParticipation.create(
        question_answer_pair: @question_answer_pair
      )
    end
  end
end
