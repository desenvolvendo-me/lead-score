require 'csv'

  module Scoring
    class ScoreCsvExporter
      def self.generate(scores)
        CSV.generate(headers: true) do |csv|
          csv << ['Name', 'Score']
          scores.each do |score|
            csv << [score.name, score.value]
          end
        end
      end
    end
  end



