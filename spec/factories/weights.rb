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
    question_answer do
      {
        "Você já comprou algum curso de Programação?" => { "Sim" => 5, "Não" => 1 },
        "Você está em transição de carreira?" => { "Sim" => 4, "Não" => 2 }
      }
    end
  end
end
