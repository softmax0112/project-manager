# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def edit?
    return ((user.id == record.id) && (user.role == record.role)) unless user.admin?

    true
  end

  def update?
    return ((user.id == record.id) && (user.role == record.role)) unless user.admin?

    true
  end

  def change_password?
    ((user.id == record.id) && (user.role == record.role))
  end

  def update_password?
    ((user.id == record.id) && (user.role == record.role))
  end

  def show?
    return ((user.id == record.id) && (user.role == record.role)) unless user.admin?

    true
  end

  def create?
    user.admin?
  end

  def new?
    user.admin?
  end

  def destroy?
    user.admin?
  end

  def toggle?
    user.admin?
  end
end
