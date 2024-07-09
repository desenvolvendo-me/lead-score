module Score
  class Calculator
    def self.calculate_score(json_lead_answers, answers_weights)
      total_score = 0
      lead_answers = json_lead_answers["answers"]

      lead_answers.each do |question, answer|
        total_score += answers_weights[question][answer]
      end

      total_score
    end
  end
end
