# == Schema Information
#
# Table name: weights
#
#  id              :bigint           not null, primary key
#  description     :string
#  question_answer :jsonb            not null
#  status          :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
FactoryBot.define do
  factory :weight do
    description { "Turma 21" }
    status { "active" }
    question_answer { { "pergunta1" => { "resposta1" => 10, "resposta2" => 5 } } }
  end
end
