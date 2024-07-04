require 'rails_helper'

RSpec.describe ScoresController, type: :controller do
  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to be_successful
    end

    it "renders the correct template" do
      get :index
      expect(response).to render_template('manager/scores/index')
    end

  end
end
