module Score
  class Calculator
    def self.calculate_score(json_answers, json_weights)
      total_score = 0


      json_answers.each do |question, answer|
        total_score += json_weights[question][answer]
      end

      total_score
    end
  end
end
