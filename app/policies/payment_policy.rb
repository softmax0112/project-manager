# frozen_string_literal: true

class PaymentPolicy < ApplicationPolicy
  def edit?
    user.admin? || user.manager?
  end

  def update?
    user.admin? || user.manager?
  end

  def show?
    user.admin? || user.manager?
  end

  def create?
    user.admin? || user.manager?
  end

  def new?
    user.admin? || user.manager?
  end

  def destroy?
    user.admin? || user.manager?
  end
end
