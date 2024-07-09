# spec/controllers/manager/scores_controller_spec.rb

require 'rails_helper'

RSpec.describe Manager::ScoresController, type: :controller do
  describe 'GET #index' do
    it 'assigns @scores' do
      # Simulate user authentication (example with Devise)
      user = create(:user)  # Assuming you have a User model and a factory setup
      sign_in user

      get :index
      expect(assigns(:scores)).to eq(Score.all)
    end

    it 'renders the index template' do
      # Simulate user authentication
      user = create(:user)
      sign_in user

      get :index
      expect(response).to render_template('index')
    end
  end
end
