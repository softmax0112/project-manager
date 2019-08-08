# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  def edit?
    return (user.id == record.user_id) unless user.admin?

    true
  end

  def update?
    return (user.id == record.user_id) unless user.admin?

    true
  end

  def destroy?
    return (user.id == record.user_id) unless user.admin?

    true
  end
end
