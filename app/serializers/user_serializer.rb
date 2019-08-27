# frozen_string_literal: true

class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :email, :name, :enabled, :role, :image

  has_many :time_logs
  has_many :projects
  has_many :comments
end
