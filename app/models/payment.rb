# frozen_string_literal: true

class Payment < ApplicationRecord
  belongs_to :projects, optional: true
  belongs_to :user, foreign_key: 'creator_id'

  validates :amount, presence: true
  validates :creator_id, presence: true
  validates :project_id, presence: true
  validates_numericality_of :amount, lesser_than: 99_999_999, greater_than: 0
end
