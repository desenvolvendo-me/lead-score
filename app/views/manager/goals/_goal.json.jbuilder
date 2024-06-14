json.extract! goal, :id, :name, :description, :image,
              :client_id, :created_at, :updated_at
json.url manager_goal_url(goal, format: :json)
