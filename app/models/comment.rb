# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :commenter, class_name: 'User'

  validates :comment, presence: true, length: { maximum: 255 }
  validates :commenter, presence: true, length: { maximum: 255 }
  validates :commentable_id, presence: true
  validates :commentable_type, presence: true

  belongs_to :commentable, polymorphic: true

  def self.search(id, type)
    where('commentable_id = ? AND commentable_type = ?', id, type).order('created_at DESC')
  end
end
