require 'rails_helper'

RSpec.describe Manager::ScoresController, type: :controller do
  let(:user) { create(:user) }

  before do
    sign_in user
    get :index
  end

  describe 'GET #index' do
    it 'assigns @scores' do
      expect(assigns(:scores)).to eq(Score.all)
    end

    it 'assigns @scores to not be nil' do
      expect(assigns(:scores)).to_not be_nil
    end

    it 'renders the index template' do
      expect(response).to render_template('index')
    end
  end
end
