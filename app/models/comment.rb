# frozen_string_literal: true

class Comment < ApplicationRecord
  validates :comment, presence: true, length: { minimum: 1, maximum: 150 }
  validates :commenter, presence: true, length: { minimum: 1, maximum: 150 }
  validates :commentable_id, presence: true
  validates :commentable_type, presence: true

  belongs_to :commentable, polymorphic: true, optional: true
end
