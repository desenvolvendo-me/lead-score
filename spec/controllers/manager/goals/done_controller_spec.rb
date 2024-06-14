require 'rails_helper'

RSpec.describe Manager::Goals::DoneController,
               type: :controller do
  let!(:user) { create(:user) }
  let!(:client) { create(:client, user: user) }
  let!(:goal) { create(:goal, client: client) }
  let!(:goals) { create_list(:goal, 3, client: client) }

  before(:each) do
    allow_any_instance_of(InternalController)
      .to receive(:authenticate_user!).and_return(true)
  end

  context 'POST #index' do
    it 'status todo to done' do
      expect do
        post :index,
             params: { goal_id: goal.id }
      end.to change { goal.reload.status }.from('todo').to('done')
      expect(flash[:notice]).to eq(I18n.t('manager.goals.done.other'))
    end
  end

  context 'POST #show' do
    it 'status todo to done' do
      expect do
        post :show,
             params: { goal_id: goal.id }
      end.to change { goal.reload.status }.from('todo').to('done')
      expect(flash[:notice]).to eq(I18n.t('manager.goals.done.one'))
    end
  end

  context 'POST #many' do
    it 'status todo to done' do
      expect do
        post :many,
             params: { goal_ids: goals.pluck(:id) }, as: :json
      end.to change { goals.first.reload.status }.from('todo').to('done')
      expect(JSON.parse(response.body)['message'])
        .to(eq(I18n.t('manager.goals.done.other')))
    end
  end
end
