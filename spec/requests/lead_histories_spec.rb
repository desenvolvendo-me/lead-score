require 'rails_helper'

RSpec.describe "LeadHistories", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/lead_histories/index"
      expect(response).to have_http_status(:success)
    end
  end

end
