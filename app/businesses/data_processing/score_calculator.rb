module DataProcessing
  class ScoreCalculator
    def self.calculate_score(json_answers, json_weights)
      total_score = 0

      # Process answers
      json_answers.each do |question_data, answer_data|
        total_score += json_weights[question_data][answer_data]
      end

      total_score
    end
  end
end
