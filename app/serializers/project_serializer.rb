# frozen_string_literal: true

class ProjectSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :description, :hours_spent, :total_payment

  has_many :payments
  has_many :time_logs
  has_many :comments
  has_many :attachments
  has_many :users

  belongs_to :client
  belongs_to :manager, record_type: :user
  belongs_to :creator, record_type: :user
end
