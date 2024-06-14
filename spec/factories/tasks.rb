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
FactoryBot.define do
  factory :task do
    name { '1ª agoritmo' }
    description { 'Criar o algoritmo bubble sort' }
    status { 'todo' }
  end
end
