# == Schema Information
#
# Table name: answers
#
#  id              :bigint           not null, primary key
#  question_answer :jsonb
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'rails_helper'

RSpec.describe Answer, type: :model do
  it 'can be created' do
    answer_table = Answer.new(question_answer: { "What is your age?" => "33" })
    expect(answer_table).to be_a_new(Answer)
  end

  it 'can be saved' do
    answer_table = Answer.new(question_answer: { "What is your age?" => "33" })
    expect(answer_table.save).to be_truthy
  end

  it 'can be found' do
    answer_table = Answer.create!(question_answer: { "What is your age?" => "33" })
    expect(Answer.find(answer_table.id)).to eq(answer_table)
  end

  it 'can be updated' do
    answer_table = Answer.create!(question_answer: { "What is your age?" => "33" })
    answer_table.update(question_answer: { "question" => "What is your age?", "answer" => "30" })
    expect(answer_table.question_answer).to eq({ "question" => "What is your age?", "answer" => "30" })
  end

  it 'can be destroyed' do
    answer_table = Answer.create!(question_answer: { "What is your age?" => "33" })
    expect { answer_table.destroy }.to change { Answer.count }.by(-1)
  end
end
