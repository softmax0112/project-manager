# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    redirect_user_role if user_signed_in?
  end

  def redirect_user_role
    if current_user.admin?
      redirect_to admin_user_path(current_user)
    else
      redirect_to base_user_path(current_user)
    end
  end
end
