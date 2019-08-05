# frozen_string_literal: true

json.extract! attachment, :id, :filename, :projects_id, :created_at, :updated_at
json.url attachment_url(attachment, format: :json)
