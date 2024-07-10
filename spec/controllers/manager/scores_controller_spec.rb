require 'rails_helper'

RSpec.describe Manager::ScoresController, type: :controller do
  describe 'GET #index' do
    it 'assigns @scores' do
      user = create(:user)
      sign_in user

      get :index
      expect(assigns(:scores)).to eq(Score.all)
    end

    it 'renders the index template' do
      user = create(:user)
      sign_in user

      get :index
      expect(response).to render_template('index')
    end
  end
end
