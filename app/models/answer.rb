# == Schema Information
#
# Table name: answer_tables
#
#  id              :bigint           not null, primary key
#  question_answer :jsonb
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Answer < ApplicationRecord
end
