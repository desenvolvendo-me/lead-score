module DataProcessing
  class ScoreCalculator
    def self.calculate_score
      total_score = 0
      json_lead_answers = AnswerTable.take.question_answer
      answers_weights = WeightTable.take.question_answer
      lead_answers = json_lead_answers["answers"]


      lead_answers.each do |question, answer|
        total_score += answers_weights[question][answer]
      end

      total_score
    end
  end
end
