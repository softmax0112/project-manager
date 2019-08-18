# frozen_string_literal: true

class TimeLog < ApplicationRecord
  belongs_to :project
  belongs_to :user
  has_many :comments, as: :commentable

  validates :hours, presence: true
  validates :project_id, presence: true
  validates :user_id, presence: true
  validates_numericality_of :hours, lesser_than: 20, greater_than: 0

  COMMENTS_PREVIEW_COUNT = 3

  def self.search(project_id, user = nil)
    time_logs = where(project_id: project_id)
    user.user? ? time_logs.where(user_id: user.id) : time_logs
  end
end
