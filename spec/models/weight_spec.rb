
require 'rails_helper'

RSpec.describe Weight, type: :model do
  it 'can be created' do
    weight_table = Weight.new(question_answer: { "What is your age?" => { "33" => 5, "55" => 1 }})
    expect(weight_table).to be_a_new(Weight)
  end

  it 'can be saved' do
    weight_table = Weight.new(question_answer: { "What is your age?" => { "33" => 5, "55" => 1 }})
    expect(weight_table.save).to be_truthy
  end

  it 'can be found' do
    weight_table = Weight.create!(question_answer: { "What is your age?" => { "33" => 5, "55" => 1 }})
    expect(Weight.find(weight_table.id)).to eq(weight_table)
  end

  it 'can be updated' do
    weight_table = Weight.create!(question_answer: { "What is your age?" => { "33" => 5, "55" => 1 }})
    weight_table.update(question_answer: { "What is your age?" => { "33" => 2, "55" => 3 }})
    expect(weight_table.question_answer).to eq({ "What is your age?" => { "33" => 2, "55" => 3 }})
  end

  it 'can be destroyed' do
    weight_table = Weight.create!(question_answer: { "What is your age?" => { "33" => 5, "55" => 1 }})
    expect { weight_table.destroy }.to change { Weight.count }.by(-1)
  end
end
