# spec/models/score_spec.rb

require 'rails_helper'

RSpec.describe Score, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      score = Score.new(name: 'Test Score', value: 10)
      expect(score).to be_valid
    end

    it 'is not valid without a name' do
      score = Score.new(name: nil, value: 10)
      expect(score).to_not be_valid
    end

    it 'is not valid without a value' do
      score = Score.new(name: 'Test Score', value: nil)
      expect(score).to_not be_valid
    end
  end

  describe 'default values' do
    it 'has a default value for data' do
      score = Score.new(name: 'Test Score', value: 10)
      expect(score.data).to eq({})
    end
  end

  describe '#to_s' do
    it 'returns the name of the score' do
      score = Score.new(name: 'Test Score', value: 10)
      expect(score.to_s).to eq('Test Score')
    end
  end
end
