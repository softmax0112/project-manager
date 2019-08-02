# frozen_string_literal: true

json.extract! payment, :id, :amount, :projects_id, :creator_id, :created_at, :updated_at
json.url payment_url(payment, format: :json)
