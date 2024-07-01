module DataProcessing
  class JsonLoader
    def self.import_answers(table_name, table_field, table_id)

      query = ActiveRecord::Base.sanitize_sql(["SELECT * FROM #{table_name} WHERE id = ?", table_id])
      answered_quiz = ActiveRecord::Base.connection.execute(query).first

      return [] if answered_quiz.blank?

      json_data = JSON.parse(answered_quiz[table_field])
      quiz = []

      json_data.each do |lead_data|
        lead = lead_data['lead']
        answers = lead_data['answers']

        quiz << [lead, answers]
      end

      quiz
    end
  end
end
