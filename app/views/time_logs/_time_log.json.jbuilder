# frozen_string_literal: true

json.extract! time_log, :id, :project_id, :user_id, :hours, :created_at, :updated_at
json.url time_log_url(time_log, format: :json)
