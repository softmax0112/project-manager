# frozen_string_literal: true

class TimeLogPolicy < ApplicationPolicy
  def index?
    true
  end

  def edit?
    user.admin?
  end

  def update?
    user.admin?
  end

  def new?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def destroy?
    return (user.id == record.user_id) unless user.admin?

    true
  end
end
