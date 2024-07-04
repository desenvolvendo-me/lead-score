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
require 'rails_helper'

RSpec.describe WeightTable, type: :model do
  it "valid" do
    weight_table = WeightTable.create(description: "Turma 21", status: "active", question_answer: { "pergunta": { "resposta": 10 } })

    expect(weight_table.valid?).to be_truthy
  end

  it "invalid" do
    weight_table = WeightTable.create(description: "Turma 21", status: "active", question_answer: { "pergunta": { "resposta": "peso" } })

    expect(weight_table.valid?).to be_falsey
  end
end
