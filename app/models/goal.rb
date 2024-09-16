# == Schema Information
#
# Table name: goals
#
#  id          :bigint           not null, primary key
#  description :string
#  finished_at :datetime
#  name        :string
#  status      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  client_id   :integer
#
class Goal < ApplicationRecord
  acts_as_tenant :client

  enum status: { backlog: 'backlog', todo: 'todo', block: 'block',
                 doing: 'doing', done: 'done' }

  belongs_to :client

  validates :name, presence: true

  after_update :after_update

  def after_update
    GoalFinishedJob.perform_later(self)
  end

  def to_s
    name
  end
end
