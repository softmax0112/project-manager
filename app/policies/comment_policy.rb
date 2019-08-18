# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  def index?
    true
  end

  def new?
    return (user.id == record.commenter_id) unless user.admin?

    true
  end

  def create?
    return (user.id == record.commenter_id) unless user.admin?

    true
  end

  def edit?
    return (user.id == record.commenter_id) unless user.admin?

    true
  end

  def update?
    return (user.id == record.commenter_id) unless user.admin?

    true
  end

  def destroy?
    return (user.id == record.commenter_id) unless user.admin?

    true
  end
end
