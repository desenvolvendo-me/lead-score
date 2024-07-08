# == Schema Information
#
# Table name: answer_tables
#
#  id              :bigint           not null, primary key
#  question_answer :jsonb
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'rails_helper'

RSpec.describe AnswerTable, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
