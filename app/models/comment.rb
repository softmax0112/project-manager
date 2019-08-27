# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :commenter, class_name: 'User'
  belongs_to :commentable, polymorphic: true

  validates :comment, presence: true, length: { maximum: 255 }
  validates :commenter, presence: true, length: { maximum: 255 }

  def self.fetch_commentable_comments(id, type)
    where('commentable_id = ? AND commentable_type = ?', id, type).order('created_at DESC')
  end
end
