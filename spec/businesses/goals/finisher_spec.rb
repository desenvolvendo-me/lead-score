require 'rails_helper'

RSpec.describe Goals::Finisher do
  before do
    Sidekiq::Testing.inline!
  end

  describe 'goal' do
    context 'done' do
      it 'with task' do
        goal = create(:goal, :with_tasks)

        expect { goal.done! }.to change(goal, :status).from('todo').to('done')
        goal.tasks.each do |task|
          expect(task.reload.status).to eq('done')
        end
      end

      it 'without task' do
        goal = create(:goal)

        expect { goal.done! }.to change(goal, :status).from('todo').to('done')
      end
    end

    context 'doing' do
      it do
        goal = create(:goal, :with_tasks)

        expect { goal.doing! }.to change(goal, :status).from('todo').to('doing')
        goal.tasks.each do |task|
          expect(task.reload.status).to eq('todo')
        end
      end
    end
  end
end
