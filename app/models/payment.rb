# frozen_string_literal: true

class Payment < ApplicationRecord
  belongs_to :project
  belongs_to :creator, class_name: 'User'

  has_many :comments, as: :commentable

  validates :amount, presence: true
  validate :amount_limits

  before_update :set_amount
  after_update :project_updation

  def amount_limits
    if amount > 99_999_999
      errors.add(:amount, 'can not be greater than 99,999,999')
    elsif amount < 1
      errors.add(:amount, 'can not be lower than 1')
    end
  end

  COMMENTS_PREVIEW_COUNT = 3

  def set_amount
    @amount_before_update = amount_was
  end

  def self.fetch_project_payments(project_id)
    where(project_id: project_id)
  end

  def project_updation
    @amount_after_update = amount
    @difference = @amount_after_update - @amount_before_update
    @new_payment = (project.total_payment + @difference)
    project.total_payment = @new_payment
    project.save
  end
end
