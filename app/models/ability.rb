# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.user?
      can :read, :all
    else
      can :manage, :all
    end
  end
end
