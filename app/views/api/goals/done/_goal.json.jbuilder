json.id goal.id
json.name goal.name
json.description goal.description
json.finished_at goal.finished_at
json.status goal.status

json.tasks goal.tasks, partial: 'task', as: :task, cached: true
