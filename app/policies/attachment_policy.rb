# frozen_string_literal: true

class AttachmentPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    true
  end

  def new?
    true
  end

  def destroy?
    user.admin?
  end
end
