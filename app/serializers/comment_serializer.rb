# frozen_string_literal: true

class CommentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :comment, :commentable_type
  belongs_to :commenter
end
