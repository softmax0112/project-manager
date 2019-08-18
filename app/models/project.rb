# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :manager, class_name: 'User'
  belongs_to :creator, class_name: 'User'
  has_many :payments, dependent: :destroy, after_add: :add_to_payments,
                      after_remove: :remove_from_payments
  has_many :time_logs, dependent: :destroy, after_add: :add_to_time,
                       after_remove: :remove_from_time
  belongs_to :client
  has_and_belongs_to_many :users
  has_many :attachments, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, length: { maximum: 255 }
  validates :manager_id, presence: true
  validates :creator_id, presence: true
  validates :client_id, presence: true

  COMMENTS_PREVIEW_COUNT = 3
  ATTACHMENTS_PREVIEW_COUNT = 5

  def self.search(term)
    term.present? ? projects.where('title LIKE ?', "%#{term}%") : self
  end

  def add_to_payments(payment)
    self[:total_payment] += payment.amount
    save
  end

  def remove_from_payments(payment)
    self[:total_payment] -= payment.amount
    save
  end

  def add_to_time(timelog)
    self[:hours_spent] += timelog.hours
    save
  end

  def remove_from_time(timelog)
    self[:hours_spent] -= timelog.hours
    save
  end
end
