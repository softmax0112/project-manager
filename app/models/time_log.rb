# frozen_string_literal: true

class TimeLog < ApplicationRecord
  belongs_to :project
  belongs_to :user

  has_many :comments, as: :commentable

  validates :hours, presence: true
  validate :hour_limits

  before_update :set_hours
  after_update :project_updation

  def hour_limits
    if hours > 20
      errors.add(:hours, 'can not be greater than 20')
    elsif hours < 1
      errors.add(:hours, 'can not be lower than 1')
    end
  end

  COMMENTS_PREVIEW_COUNT = 3

  def self.search(project_id, user = nil)
    time_logs = where(project_id: project_id)
    user.user? ? time_logs.where(user_id: user.id) : time_logs
  end

  def self.fetch_project_logs(project_id)
    where(project_id: project_id)
  end

  def set_hours
    @hours_before_update = hours_was
  end

  def project_updation
    @hours_after_update = hours
    @difference = @hours_after_update - @hours_before_update
    @new_hours = (project.hours_spent + @difference)
    project.hours_spent = @new_hours
    project.save
  end
end
