# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :user, foreign_key: 'manager_id'
  belongs_to :user, foreign_key: 'creator_id'
  belongs_to :client

  def manager
    User.find(manager_id)
  end

  def creator
    User.find(creator_id)
  end

  def client
    Client.find(client_id)
  end
end
