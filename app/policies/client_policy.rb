# frozen_string_literal: true

class ClientPolicy < ApplicationPolicy
  def index?
    return true
  end

  def edit?
    user.admin? || user.manager?
  end

  def update?
    user.admin? || user.manager?
  end

  def show?
    return true
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
end
