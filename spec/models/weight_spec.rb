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
require 'rails_helper'

RSpec.describe Weight do
  it "valid" do
    weight = Weight.create(description: "Turma 21", status: "active", question_answer: { "pergunta1" => { "resposta1" => 10, "resposta2" => 5 }})

    expect(weight.valid?).to be_truthy
  end

  it "invalid" do
    weight = Weight.create(description: "Turma 21", status: "active", question_answer: { "pergunta1" => { "resposta1" => 10, "resposta2" => "" } } )

    expect(weight.valid?).to be_falsey
  end

  it "invalid" do
    weight = Weight.create(description: "Turma 21", status: "active", question_answer: { "" => { "resposta1" => 10, "resposta2" => 5 } } )

    expect(weight.valid?).to be_falsey
  end

  it "invalid" do
    weight = Weight.create(description: "Turma 21", status: "active", question_answer: { "pergunta1" => { "" => 10, "resposta2" => 5 } } )

    expect(weight.valid?).to be_falsey
  end

  it "invalid" do
    weight = Weight.create(description: "Turma 21", status: "active", question_answer: { "pergunta1" => { "resposta1" => "", "resposta2" => 5 } } )

    expect(weight.valid?).to be_falsey
  end

end
