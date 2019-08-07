# frozen_string_literal: true

class TimeLog < ApplicationRecord
  belongs_to :projects, optional: true
  has_many :comments, as: :commentable

  validates :hours, presence: true
  validates :project_id, presence: true
  validates :user_id, presence: true
  validates_numericality_of :hours, lesser_than: 20, greater_than: 0
end
