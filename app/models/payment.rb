# frozen_string_literal: true

class Payment < ApplicationRecord
  belongs_to :project
  belongs_to :creator, class_name: 'User'
  has_many :comments, as: :commentable

  validates :amount, presence: true
  validates :creator_id, presence: true
  validates :project_id, presence: true
  validates_numericality_of :amount, lesser_than: 99_999_999, greater_than: 0

  COMMENTS_PREVIEW_COUNT = 3
end
