# frozen_string_literal: true

module SurveyParticipations
  class ConsistencyChecker < BusinessApplication
    INCONSISTENCY_MESSAGES = {
      not_found_question: "The question: '%<question>s', was not found",
      not_found_answer: "The answer: '%<answer>s' to the %<question>s question, was not found"
    }.freeze

    def initialize(survey_participation)
      @survey_participation = survey_participation
    end

    def call
      @survey_participation.inconsistency_details = []

      check_consistency

      update_consistency_status
    end

    private

    def check_consistency
      @survey_participation.question_answer_pair.each do |question, answer|
        next unless check_question_exists(question)

        check_answer_exists(question, answer)
      end
    end

    def check_question_exists(question)
      if question.blank? || find_weight_by_question(question).nil?
        add_inconsistency(format(INCONSISTENCY_MESSAGES[:not_found_question],
                                 question: question))
        return false
      end
      true
    end

    def check_answer_exists(question, answer)
      weight = find_weight_by_question(question)
      return if weight.question_answer[question].key?(answer)

      add_inconsistency(format(INCONSISTENCY_MESSAGES[:not_found_answer],
                               question: question, answer: answer))
    end

    def find_weight_by_question(question)
      @weight_cache ||= {}
      @weight_cache[question] ||= Weight.find_by('question_answer ? :key',
                                                 key: question)
    end

    def add_inconsistency(message)
      return if @survey_participation.inconsistency_details.include?(message)

      @survey_participation.inconsistency_details << message
    end

    def update_consistency_status
      status = if @survey_participation.inconsistency_details.empty?
                 :consistent
               else
                 :inconsistent
               end
      @survey_participation.consistency_status = status
    end
  end
end
