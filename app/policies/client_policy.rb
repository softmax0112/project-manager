# frozen_string_literal: true

class ClientPolicy < ApplicationPolicy
  def index?
    true
  end

  def edit?
    user.admin? || user.manager?
  end

  def update?
    user.admin? || user.manager?
  end

  def show?
    true
  end

  def create?
    user.admin? || user.manager?
  end

  def new?
    user.admin? || user.manager?
  end

  def destroy?
    user.admin?
  end
end
