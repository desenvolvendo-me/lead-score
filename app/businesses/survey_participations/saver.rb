# frozen_string_literal: true

module SurveyParticipations
  class Saver < BusinessApplication
    def initialize(survey)
      @survey = survey
    end

    def call
      return if @survey.empty?

      map_survey_data
      create_survey_participations
    end

    private

    def create_survey_participations
      @survey_participations.each do |survey_participation|
        SurveyParticipation.create(
          question_answer_pair: survey_participation
        )
      end
    end

    def map_survey_data
      @survey_participations = SurveyParticipations::SurveyDataMapper.call(@survey)
    end
  end
end
