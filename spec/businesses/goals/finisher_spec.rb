require 'rails_helper'

RSpec.describe Goals::Finisher do
  before do
    Sidekiq::Testing.inline!
  end

  describe 'goal' do
    context 'done' do
      it 'without task' do
        goal = create(:goal)

        expect { goal.done! }.to change(goal, :status).from('todo').to('done')
      end
    end
  end
end
