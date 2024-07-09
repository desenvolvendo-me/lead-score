FactoryBot.define do
  factory :weight_table do
    description { "Turma 21" }
    status { "active" }
    question_answer { { "pergunta1" => { "resposta1" => 10, "resposta2" => 5 } } }
  end
end
