json.extract! project, :id, :title, :description, :hours_spent, :total_payment, :manager_id, :creator_id, :created_at, :updated_at
json.url project_url(project, format: :json)
