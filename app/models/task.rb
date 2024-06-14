# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  description :string
#  finished_at :datetime
#  name        :string
#  status      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  goal_id     :bigint
#
# Indexes
#
#  index_tasks_on_goal_id  (goal_id)
#
class Task < ApplicationRecord
  belongs_to :goal

  enum status: { backlog: 'backlog', todo: 'todo', block: 'block',
                 doing: 'doing', done: 'done' }

  validates :name, presence: true
end
