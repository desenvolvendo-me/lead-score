require 'rails_helper'

RSpec.describe WeightsController, type: :controller do
  let(:weight) { Weight.create!(description: "Turma 21", status: "active", question_answer: {"pergunta1" => { "resposta1" => 10, "resposta2" => 5 }}.to_json) }
  describe "GET #index" do
    it "returns a success response and assigns @weights" do
      get :index
      expect(response).to have_http_status(:success)
      expect(assigns(:weights)).to include(weight)
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: weight.id }
      expect(response).to have_http_status(:success)
      expect(assigns(:weight)).to eq(weight)
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to have_http_status(:success)
      expect(assigns(:weight)).to be_a_new(Weight)
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      get :edit, params: { id: weight.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it "creates a new Weight and redirects to its show page" do
      post :create, params: { weight: { description: "New Weight", status: "active", question_answer: {"pergunta1" => { "resposta1" => 15, "resposta2" => 7 }}.to_json } }
      expect(response).to redirect_to(Weight.last)
      expect(flash[:notice]).to eq('Weight was successfully created.')
    end
  end

  describe "PATCH #update" do
    it "updates the requested weight and redirects to its show page" do
      patch :update, params: { id: weight.id, weight: { description: "Updated Description" } }
      weight.reload
      expect(weight.description).to eq("Updated Description")
      expect(response).to redirect_to(weight)
      expect(flash[:notice]).to eq('Weight was successfully updated.')
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested weight and redirects to the index page" do
      delete :destroy, params: { id: weight.id }
      expect(Weight.exists?(weight.id)).to be_falsey
      expect(response).to redirect_to(weights_url(only_path: true))
      expect(flash[:notice]).to eq('Weight was successfully destroyed.')
    end
  end
end