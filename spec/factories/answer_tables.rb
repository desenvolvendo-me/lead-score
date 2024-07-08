# == Schema Information
#
# Table name: answer_tables
#
#  id              :bigint           not null, primary key
#  question_answer :jsonb
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
FactoryBot.define do
  factory :answer_table do
    question_answer {
      {
        lead: {
          name: "Marco",
          email: "marcodotcastro@gmail.com",
          telefone: "18121212"
        },
        answers: {
          "Você já comprou algum curso de Programação?" => "Sim",
          "Você está em transição de carreira?" => "Sim"
        }
      }
    }
  end
end
