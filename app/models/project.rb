# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :manager, class_name: 'User'
  belongs_to :creator, class_name: 'User'
  belongs_to :client

  has_many :attachments, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :payments, dependent: :destroy, after_add: :add_to_payments,
                      after_remove: :remove_from_payments
  has_many :time_logs, dependent: :destroy, after_add: :add_to_time,
                       after_remove: :remove_from_time

  has_and_belongs_to_many :users

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, length: { maximum: 255 }

  COMMENTS_PREVIEW_COUNT = 3
  ATTACHMENTS_PREVIEW_COUNT = 5

  def self.search(term)
    projects = self
    projects = projects.where('title LIKE ?', "%#{term}%") if term.present?
    projects
  end

  def self.highest_earning
    order('total_payment DESC').limit(5)
  end

  def self.lowest_earning
    order('total_payment ASC').limit(5)
  end

  def self.sort_by_payment_this_month
    all.includes(:payments).sort_by(&:payment_this_month)
  end

  def self.sort_by_time_logged_this_month
    all.includes(:time_logs).sort_by(&:time_logged_this_month)
  end

  def payment_this_month
    payments.where('strftime("%m", created_at) = ? AND strftime("%Y", created_at) = ?', "0#{Date.today.month}", "#{Date.today.year}").sum(:amount)
  end

  def time_logged_this_month
    time_logs.where('strftime("%m", created_at) = ? AND strftime("%Y", created_at) = ?', "0#{Date.today.month}", "#{Date.today.year}").sum(:hours)
  end

  def add_to_payments(payment)
    self.total_payment += payment.amount
    save
  end

  def remove_from_payments(payment)
    self.total_payment -= payment.amount
    save
  end

  def add_to_time(timelog)
    self.hours_spent += timelog.hours
    save
  end

  def remove_from_time(timelog)
    self.hours_spent -= timelog.hours
    save
  end
end
