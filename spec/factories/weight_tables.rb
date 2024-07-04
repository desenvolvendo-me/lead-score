# == Schema Information
#
# Table name: weight_tables
#
#  id              :bigint           not null, primary key
#  description     :string
#  question_answer :jsonb            not null
#  status          :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
FactoryBot.define do
  factory :weight_table do
    description { "Turma 21" }
    status { "active" }
    question_answer { {"pergunta"=>{"resposta"=>10}} }
  end
end
