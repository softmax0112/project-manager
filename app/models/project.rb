# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :user, foreign_key: 'manager_id'
  belongs_to :user, foreign_key: 'creator_id'
  has_many :payments, dependent: :destroy, after_add: :add_to_payments,
                      after_remove: :remove_from_payments
  has_many :time_logs, dependent: :destroy, after_add: :add_to_time,
                       after_remove: :remove_from_time
  belongs_to :client
  has_many :projects_users, dependent: :destroy
  has_many :users, through: :projects_users

  def manager
    User.find(manager_id)
  end

  def creator
    User.find(creator_id)
  end

  def client
    Client.find(client_id)
  end

  def add_to_payments(payment)
    self[:total_payment] += payment.amount
  end

  def remove_from_payments(payment)
    self[:total_payment] -= payment.amount
  end

  def add_to_time(timelog)
    self[:hours_spent] += timelog.hours
  end

  def remove_from_time(timelog)
    self[:hours_spent] -= timelog.hours
  end
end
