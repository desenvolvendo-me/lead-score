require 'rails_helper'

RSpec.describe WeightValidator do
  describe "#valid_structure?" do
    it "returns true for valid JSON structure" do
      json_data = '{"pergunta1": {"resposta1": 10, "resposta2": 5}}'
      expect(WeightValidator.valid_structure?(json_data)).to be_truthy
    end

    it "returns false if JSON is not a hash" do
      json_data = '[{"pergunta1": {"resposta1": 10, "resposta2": 5}}]'
      expect(WeightValidator.valid_structure?(json_data)).to be_falsey
    end

    it "returns false if keys are not strings" do
      json_data = '{123: {"resposta1": 10, "resposta2": 5}}'
      expect(WeightValidator.valid_structure?(json_data)).to be_falsey
    end

    it "returns false if inner keys are not strings" do
      json_data = '{"pergunta1": {123: 10, "resposta2": 5}}'
      expect(WeightValidator.valid_structure?(json_data)).to be_falsey
    end

    it "returns false if inner values are not numeric" do
      json_data = '{"pergunta1": {"resposta1": "peso", "resposta2": 5}}'
      expect(WeightValidator.valid_structure?(json_data)).to be_falsey
    end
  end
end
