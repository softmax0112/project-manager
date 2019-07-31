# frozen_string_literal: true

json.array! @manager_clients, partial: 'manager_clients/manager_client', as: :manager_client
