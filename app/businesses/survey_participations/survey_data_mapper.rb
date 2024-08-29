# frozen_string_literal: true

module SurveyParticipations
  class SurveyDataMapper < BusinessApplication
    def initialize(survey)
      @survey = survey
    end

    def call
      remove_date_elements
      map_questions_and_answers
    end

    private

    def remove_date_elements
      @survey.each do |obj|
        obj.delete('0')
      end
    end

    def map_questions_and_answers
      header = @survey[0]
      @survey[1..].map do |row|
        row.transform_keys { |key| header[key] }
      end
    end
  end
end
